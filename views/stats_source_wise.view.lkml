view: stats_source_wise {
derived_table: {
  sql: WITH
client_info AS (
    SELECT id, name
    FROM idp.modelled.campaign_management_clients
),
cam_info AS (
    SELECT id, name
    FROM idp.modelled.campaign_management_campaigns
),
jg_info AS (
    SELECT id, name
    FROM idp.modelled.campaign_management_jobgroups
),
stats AS (
    SELECT
        agency_id, client_id, campaign_id, job_group_id, publisher_id, event_publisher_date,
        SUM(
            CASE
                WHEN is_valid = TRUE THEN (
                    event_spend * (1E0 / (1E0 - (publisher_entity_markdown / 100))) * (1E0 + (agency_markup / 100)) * (1E0 + (effective_cd_markup / 100)) * d_logic_ratio
                )
                ELSE 0E0
            END
        ) AS CDSpend
    FROM
        tracking.modelled.view_tracking_event vte
    WHERE
        agency_id = 'uberjax'
        AND event_publisher_date BETWEEN DATE('2023-01-01') AND DATE('2023-01-31')
        AND should_contribute_to_joveo_stats = TRUE
    GROUP BY
        agency_id, client_id, campaign_id, job_group_id, publisher_id, event_publisher_date
),
stats2 AS (
    SELECT
        publisher_id
    FROM
        stats
        JOIN client_info ON stats.client_id = client_info.id
        JOIN cam_info ON stats.campaign_id = cam_info.id
        JOIN jg_info ON stats.job_group_id = jg_info.id
    WHERE
        EXISTS (
            SELECT
                1
            FROM
                (
                    SELECT
                        publisher_id, SUM(cdspend) AS total_cdspend
                    FROM
                        stats
                    GROUP BY
                        publisher_id
                    ORDER BY
                        total_cdspend DESC
                    LIMIT
                        4
                ) AS top_4_publishers
            WHERE
                top_4_publishers.publisher_id = stats.publisher_id
        )
),
stats_grouped AS (
    SELECT
        CASE
            WHEN publisher_id IN (SELECT publisher_id FROM stats2) THEN publisher_id
            ELSE 'Other'
        END AS publisher_group,
        event_publisher_date,
        SUM(CDSpend) AS total_cdspend
    FROM
        stats
    GROUP BY
        publisher_group, event_publisher_date
)
SELECT
    publisher_group,
    event_publisher_date,
    total_cdspend
FROM
    stats_grouped ;;
}
dimension: publisher_id {
  type: string
  sql: ${TABLE}.publisher_group ;;
}
dimension: event_publisher_date {
  type: date
  sql: ${TABLE}.event_publisher_date ;;
}
measure: total_cdspend {
  type: sum
  sql: ${TABLE}.total_cdspend ;;
}
}

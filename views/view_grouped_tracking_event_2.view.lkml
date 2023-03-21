view: view_grouped_tracking_event_2 {
  derived_table: {sql: select agency_id,client_id,campaign_id,job_group_id,event_publisher_date,
      sum(CLICKS) clicks,
   sum(APPLIES) applies,
   sum(Apply_Starts) apply_starts,
       sum(HIRES) hires,
     sum(CD_SPEND) cd_spend
FROM   tracking.modelled.view_grouped_combined_events
       WHERE event_publisher_date >= date('2023-01-01')
       and should_contribute_to_joveo_stats = TRUE group by agency_id,client_id,campaign_id,job_group_id,event_publisher_date ;;}
  dimension: agency_id {
    type: string
    sql: ${TABLE}.agency_id ;;
  }
  dimension: client_id {
    type: string
    sql: ${TABLE}.client_id ;;
  }
  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }
  dimension: job_group_id {
    type: string
    sql: ${TABLE}.job_group_id ;;
  }
  dimension: event_publisher_date {
    type: date
    sql: ${TABLE}.event_publisher_date ;;
  }
  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }
  measure: applies {
    type: sum
    sql: ${TABLE}.applies ;;
  }
  measure: apply_starts {
    type: sum
    sql: ${TABLE}.apply_starts ;;
  }
  measure: hires {
    type: sum
    sql: ${TABLE}.hires ;;
  }
  measure: cdspend {
    type: sum
    sql: ${TABLE}.cd_spend ;;
  }
  measure: cpc {
    type: number
    sql: iff(${clicks}=0,0,${cdspend}/${clicks}) ;;
  }
  measure: cpa {
    type: number
    sql: iff(${applies}=0,0,${cdspend}/${applies}) ;;
  }
  measure: cta {
    type: number
    sql: iff(${clicks}=0,0,${applies}/${clicks}) ;;
  }
}

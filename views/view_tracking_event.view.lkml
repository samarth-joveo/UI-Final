view: view_tracking_event {
derived_table: {sql: select agency_id,client_id,campaign_id,job_group_id,publisher_id,event_publisher_date,job_state,job_country,job_city,
case
when to_time(event_timestamp) <= time_from_parts(3,0,0) then '00:00 - 03:00'
when to_time(event_timestamp) > time_from_parts(3,0,0) and to_time(event_timestamp) <= time_from_parts(6,0,0) then '03:00 - 06:00'
when to_time(event_timestamp) > time_from_parts(6,0,0) and to_time(event_timestamp) <= time_from_parts(9,0,0) then '06:00 - 09:00'
when to_time(event_timestamp) > time_from_parts(9,0,0) and to_time(event_timestamp) <= time_from_parts(12,0,0) then '09:00 - 12:00'
when to_time(event_timestamp) > time_from_parts(12,0,0) and to_time(event_timestamp) <= time_from_parts(15,0,0) then '12:00 - 15:00'
when to_time(event_timestamp) > time_from_parts(15,0,0) and to_time(event_timestamp) <= time_from_parts(18,0,0) then '15:00 - 18:00'
when to_time(event_timestamp) > time_from_parts(18,0,0) and to_time(event_timestamp) <= time_from_parts(21,0,0) then '18:00 - 21:00'
else '21:00 - 24:00'
end time_category,
   case
    when is_valid = true then (event_spend * (1E0 / (1E0 - (publisher_entity_markdown / 100))) * (1E0 + (agency_markup / 100)) * (1E0 + (effective_cd_markup / 100)) * d_logic_ratio)
    else 0E0
  end as CDSpend,
  case when (
        event_type = 'CLICK'
        and is_valid = true
      ) then event_count
      else 0
    end as Clicks,
    case
      when (
        event_type = 'CONVERSION'
        and conversion_type = 'APPLY'
      ) then event_count
      else 0
    end as Applies,
    case
      when (
        event_type = 'CONVERSION'
        and conversion_type = 'APPLY_START'
      ) then event_count
      else 0
    end as Apply_Starts,
    case
      when (
        event_type = 'CONVERSION'
        and conversion_type = 'HIRE'
      ) then event_count
      else 0
    end as Hires
from tracking.modelled.view_tracking_event
where date(event_publisher_date) >=  date('2023-01-01')
and date(event_publisher_date) <=  current_date
and should_contribute_to_joveo_stats = TRUE;;
}
  dimension: time_category {
    type: string
    sql: ${TABLE}.time_category ;;
  }
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
  dimension: publisher_id {
    type: string
    sql: ${TABLE}.publisher_id ;;
  }
  dimension: job_city {
    type: string
    sql: ${TABLE}.job_city ;;
  }
  dimension: job_state {
    type: string
    sql: ${TABLE}.job_state ;;
  }
  dimension: job_country {
    type: string
    sql: ${TABLE}.job_country ;;
  }
  measure: clicks {
    type: sum
    sql: ${TABLE}.clicks ;;
  }
  measure: applies {
    type: sum
    sql: ${TABLE}.clicks ;;
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
    sql: ${TABLE}.cdspend ;;
  }
 }

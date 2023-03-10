view: view_grouped_tracking_event {
derived_table: {sql: select client_id,campaign_id,job_group_id,event_publisher_date,monthname(event_publisher_date) month_name,
     sum(clicks) as CLICKS,
   sum(applies) as APPLIES,
   sum(apply_starts) as Apply_Starts,
       sum(hires) as HIRES,
    sum(cd_spend)
   as CD_SPEND
FROM   tracking.modelled.view_grouped_combined_events
       WHERE  agency_id='uber'
       and event_publisher_date >= date('2023-01-01')
       and should_contribute_to_joveo_stats = TRUE
GROUP  BY client_id,campaign_id,job_group_id,event_publisher_date,monthname(event_publisher_date);;}
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
  dimension: month_name {
    type: string
    sql: ${TABLE}.month_name ;;
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

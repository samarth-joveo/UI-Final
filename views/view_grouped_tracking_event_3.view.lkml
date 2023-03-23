view: view_grouped_tracking_event_3 {
  sql_table_name: tracking.modelled.view_grouped_combined_events;;

  dimension: tracking_events_pk {
    primary_key: yes
    sql: CONCAT(${TABLE}.device_type, ${TABLE}.job_group_id, ${TABLE}.publisher_id, ${TABLE}.event_publisher_date) ;;
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
  dimension_group: month_name {
    type: time
    timeframes: [month]
    sql: ${TABLE}.event_publisher_date ;;
  }
  dimension: publisher_id {
    type: string
    sql: ${TABLE}.publisher_id ;;
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


  # # You can specify the table name if it's different from the view name:
  # sql_table_name: my_schema_name.tester ;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

# view: view_grouped_tracking_event_3 {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }

view: client_info_2 {
  sql_table_name: idp.modelled.campaign_management_clients;;
  dimension: client_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  filter: agency_id {
    type: string
    sql: ${TABLE}.agency_id ;;
  }
  dimension: client_name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: client_budget{
    type: number
    sql: ${TABLE}.budget_value ;;
  }
  measure: client_budget_sum {
    type: sum
    sql: ${client_budget} ;;
  }
}

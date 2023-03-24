view: cam_view_budget {
  derived_table: {
    sql: select * from idp.modelled.campaign_management_campaigns ;;
  }
  dimension: campaign_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension: budget_value {
    type: number
    sql: ${TABLE}.budget_value ;;
  }
  measure: budget_value_measure {
    type: sum
    sql: ${budget_value} ;;
  }
}

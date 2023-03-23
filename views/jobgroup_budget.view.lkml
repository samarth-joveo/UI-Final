view: jobgroup_budget {
  sql_table_name: idp.modelled.jg_caps_view;;

  filter: agency_id {
    type: string
    sql: ${TABLE}.agency_id ;;
  }
  dimension: client_id {
    type: string
    sql: ${TABLE}.client_id ;;
  }
  dimension: jobgroup_id {
    type: string
    sql: ${TABLE}.jobgroup_id ;;
  }
  dimension: jobgroup_budget{
    type: number
    sql: ${TABLE}.jg_budget_cap_monthly_budget ;;
  }
  measure: jobgroup_budget_sum {
    type: sum
    sql: ${jobgroup_budget} ;;
  }
}

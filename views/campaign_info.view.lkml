view: campaign_info {
 derived_table: {sql:select distinct id,name,budget_value,budget_cap_frequency from idp.modelled.campaign_management_campaigns;;
}
dimension: campaign_id {
  type: string
  sql: ${TABLE}.id ;;
}
dimension: name {
  type: string
  sql: ${TABLE}.name ;;
}
  dimension: budget_value {
    type: number
    sql: ${TABLE}.budget_value ;;
  }
  dimension: budget_cap_frequency {
    type: string
    sql: ${TABLE}.budget_cap_frequency ;;
  }
}

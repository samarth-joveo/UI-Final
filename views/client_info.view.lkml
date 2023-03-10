view: client_info {
  derived_table: {sql:select distinct id,name,budget_value,budget_cap_frequency from idp.modelled.campaign_management_clients;;
    }
    dimension: client_id {
      type: string
      sql: ${TABLE}.id ;;
    }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
 }

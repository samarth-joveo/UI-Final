view: campaign_info_2 {
  sql_table_name: idp.modelled.campaign_management_campaigns;;

  filter: agency_id {
    type: string
    sql: ${TABLE}.agency_id ;;
  }
  dimension: client_id {
    type: string
    sql: ${TABLE}.client_id ;;
  }
  dimension: campaign_id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }
  dimension: campaign_name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: campaign_budget{
    type: number
    sql: ${TABLE}.budget ;;
  }
  measure: campaign_budget_sum {
    type: sum
    sql: ${campaign_budget} ;;
  }
}

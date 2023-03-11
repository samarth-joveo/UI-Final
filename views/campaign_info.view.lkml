view: campaign_info {
 derived_table: {sql:select distinct id,name from idp.modelled.campaign_management_campaigns;;
}
dimension: campaign_id {
  type: string
  sql: ${TABLE}.id ;;
}
dimension: name {
  type: string
  sql: ${TABLE}.name ;;
}
}

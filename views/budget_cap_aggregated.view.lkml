view: budget_cap_aggregated {
  derived_table: {sql:with
client_budget as (select sum(budget_value) client_budget from idp.modelled.campaign_management_clients where {% condition client_name %} name {% endcondition %} and {% condition agency_id %} agency_id {% endcondition %}),
campaign_budget as (select sum(budget_value) campaign_budget from idp.modelled.campaign_management_campaigns where {% condition campaign_name %} name {% endcondition %}),
jg_budget_outer as (with jg_budget as (select client_id,jobgroup_id,jg_budget_cap_monthly_budget from idp.modelled.jg_caps_view),
jg_name as (select id,client_id,name from idp.modelled.campaign_management_jobgroups  where {% condition jg_name %} name {% endcondition %})
select sum(jg_budget_cap_monthly_budget) jg_budget from jg_name join jg_budget on jg_name.id = jg_budget.jobgroup_id and jg_name.client_id = jg_budget.client_id)
select 1 budget_merge,* from client_budget join campaign_budget join jg_budget_outer;;}
  dimension: budget_merge {
    type: number
    sql: ${TABLE}.budget_merge ;;
  }
  filter: agency_id {
    type: string
    sql: ${view_grouped_tracking_event.agency_id} ;;
  }
dimension: client_name {
  type: string
}
dimension: campaign_name {
  type: string
}
dimension: jg_name {
  type: string
}
dimension: current_date {
  type: date
  sql: ${TABLE}.current_date ;;
}
dimension: client_budget{
  type: number
  sql: ${TABLE}.client_budget ;;
}
  dimension: campaign_budget{
    type: number
    sql: ${TABLE}.campaign_budget ;;
  }
  dimension: jg_budget{
    type: number
    sql: ${TABLE}.jg_budget ;;
  }
 }

view: budget_cap {
   derived_table: { sql: with jg_budget as (select client_id,jobgroup_id,jg_budget_cap_monthly_budget from idp.modelled.jg_caps_view),
jg_name as (select id,client_id,name from idp.modelled.campaign_management_jobgroups)
select id job_group_id,name jg_name,jg_budget_cap_monthly_budget jg_budget, null campaign_id,null campaign_name,null campaign_budget_value, null client_id,null client_name,null client_budget_value from jg_name left join jg_budget on jg_name.id = jg_budget.jobgroup_id and jg_name.client_id = jg_budget.client_id where {% condition jg_name %} jg_name {% endcondition %}
union
select distinct null job_group_id,null jg_name,null jg_budget,id campaign_id,name campaign_name, budget_value campaign_budget_value,null client_id,null client_name,null client_budget_value from idp.modelled.campaign_management_campaigns where {% condition campaign_name %} campaign_name {% endcondition %}
union
select distinct id client_id,name client_name, budget_value client_budget_value,null job_group_id,null jg_name,null jg_budget,null campaign_id,null campaign_name,null campaign_budget_value  from idp.modelled.campaign_management_clients where {% condition client_name %} client_name {% endcondition %};;}
  dimension: client_name {
    type: string
    sql: ${TABLE}.client_name ;;
  }
  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }
  dimension: jg_name {
    type: string
    sql: ${TABLE}.jg_name ;;
  }
  measure: client_budget {
    type: sum
    sql: ${TABLE}.client_budget_value ;;
  }
  measure: campaign_budget {
    type: sum
    sql: ${TABLE}.campaign_budget_value ;;
  }
  measure: jg_budget_cap_monthly_budget {
    type: sum
    sql: ${TABLE}.jg_budget ;;
  }
 }

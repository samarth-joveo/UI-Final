view: spend_with_budget_caps {
  derived_table: {
    sql: with
client_info as (select distinct id,name from idp.modelled.campaign_management_clients where {% condition client_name %} name {% endcondition %} and {% condition agency_id %} agency_id {% endcondition %}),
cam_info as (select distinct id,name from idp.modelled.campaign_management_campaigns where {% condition campaign_name %} name {% endcondition %}),
jg_info as (select distinct id,name from idp.modelled.campaign_management_jobgroups where {% condition jg_name %} name {% endcondition %}),
stats2 as (select event_publisher_date,cd_spend FROM   tracking.modelled.view_grouped_combined_events s  right join client_info on s.client_id = client_info.id right join cam_info on s.campaign_id = cam_info.id right join jg_info on s.job_group_id = jg_info.id where should_contribute_to_joveo_stats = TRUE and
{% condition agency_id %} agency_id {% endcondition %}
),
stats as (
select event_publisher_date,sum(cd_spend) cd_spend from stats2 group by event_publisher_date
),
budget_stats as (with
client_budget as (select sum(budget_value) client_budget from idp.modelled.campaign_management_clients where {% condition client_name %} name {% endcondition %} and {% condition agency_id %} agency_id {% endcondition %}),
campaign_budget as (select sum(budget_value) campaign_budget from idp.modelled.campaign_management_campaigns where {% condition campaign_name %} name {% endcondition %} and {% condition agency_id %} agency_id {% endcondition %}),
jg_budget_outer as (with jg_budget as (select client_id,jobgroup_id,jg_budget_cap_monthly_budget from idp.modelled.jg_caps_view),
jg_name as (select id,client_id,name from idp.modelled.campaign_management_jobgroups where {% condition jg_name %} name {% endcondition %} and {% condition agency_id %} agency_id {% endcondition %} )
select sum(jg_budget_cap_monthly_budget) jg_budget from jg_name left join jg_budget on jg_name.id = jg_budget.jobgroup_id and jg_name.client_id = jg_budget.client_id)
select * from client_budget join campaign_budget join jg_budget_outer)
select * from stats cross join budget_stats ;;
  }
  filter: agency_id {
    type: string
  }
  filter: client_name {
    type: string
  }
  filter: campaign_name {
    type: string
  }
  filter: jg_name {
    type: string
  }
  dimension: event_publisher_date {
    type: date
    sql: ${TABLE}.event_publisher_date ;;
  }
  dimension: client_budget {
    type: number
    sql: ${TABLE}.client_budget ;;
  }
  dimension: campaign_budget {
    type: number
    sql: ${TABLE}.campaign_budget ;;
  }
  dimension: jg_budget {
    type: number
    sql: ${TABLE}.jg_budget ;;
  }
  dimension: spend {
    type: number
    sql: ${TABLE}.cd_spend ;;
  }
  dimension: budget_cap{
    sql: {% if jg_name._is_filtered %}
          ${jg_budget}
          {% elsif campaign_name._is_filtered %}
          ${campaign_budget}
          {% elsif client_name._is_filtered %}
          ${client_budget}
          {% else %}
          ${client_budget}
          {% endif %};;
  }

 }

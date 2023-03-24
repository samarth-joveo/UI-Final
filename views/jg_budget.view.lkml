view: jg_budget {
derived_table: {
  sql: select jobgroup_id,value from idp.modelled.campaign_management_jobgroup_caps where cap_type = 'BUDGET' and entity_type = 'JOBGROUPS' ;;
}
dimension: job_group_id {
  primary_key: yes
  type: string
  sql: ${TABLE}.jobgroup_id ;;
}
dimension: budget_value {
  type: number
  sql: ${TABLE}.value ;;
}
measure: budget_value_sum {
  type: sum
  sql: ${budget_value} ;;
}
 }

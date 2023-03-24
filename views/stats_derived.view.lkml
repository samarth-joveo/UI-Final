view: stats_derived {
  derived_table: {
    sql: select client_id,campaign_id,job_group_id,event_publisher_date,sum(cd_spend) cd_spend from tracking.modelled.view_grouped_combined_events group by client_id,campaign_id,job_group_id,event_publisher_date ;;
  }
  dimension: client_id {
    type: string
    sql: ${TABLE}.client_id ;;
  }
  dimension: campaign_id {
    type: string
    sql: ${TABLE}.campaign_id ;;
  }
  dimension: job_group_id {
    type: string
    sql: ${TABLE}.job_group_id ;;
  }
  dimension: date {
    type: date
    sql: ${TABLE}.event_publisher_date ;;
  }
  measure: cd_spend {
    type: sum
    sql: ${TABLE}.cd_spend ;;
  }
  parameter: budget_cap_selection {
    type: unquoted
    allowed_value: {
      label: "JG"
      value: "j"
    }
    allowed_value: {
      label: "Campaign"
      value: "cam"
    }
    allowed_value: {
      label: "Clients"
      value: "c"
    }
  }
  measure: budget_final {
    type: sum
    sql: {% if budget_cap_selection._parameter_value == 'j' %}
      ${jg_budget.budget_value}
    {% elsif budget_cap_selection._parameter_value == 'cam' %}
      ${cam_view_budget.budget_value}
    {% else %}
     ${client_view_budget.budget_value}
    {% endif %} ;;
  }

 }

# Define the database connection to be used for this model.
connection: "idp"
include: "../views/*"
# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: ui_final_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: ui_final_default_datagroup
explore: view_grouped_tracking_event {
  access_filter: {
    field: agency_id
    user_attribute: access_agencies
  }
  access_filter: {
    field: client_id
    user_attribute: access_clients
  }

  join: client_info {
    sql_on: ${client_info.client_id} = ${view_grouped_tracking_event.client_id} ;;
    relationship: many_to_one
  }
  join: campaign_info {
    sql_on: ${campaign_info.campaign_id} = ${view_grouped_tracking_event.campaign_id} ;;
    relationship: many_to_one
  }
  join: jg_info {
    sql_on: ${jg_info.job_group_id} = ${view_grouped_tracking_event.job_group_id} ;;
    relationship: many_to_one
  }
}
explore: view_tracking_event {
  access_filter: {
    field: agency_id
    user_attribute: access_agencies
  }
  access_filter: {
    field: client_id
    user_attribute: access_clients
  }
  join: location_normalisation {
    sql_on: ${location_normalisation.job_city} = ${view_tracking_event.job_city} and ${location_normalisation.job_state} = ${view_tracking_event.job_state} and ${location_normalisation.job_country} = ${view_tracking_event.job_country} ;;
    relationship: many_to_one
 }
  join: client_info {
    sql_on: ${client_info.client_id} = ${view_tracking_event.client_id} ;;
    relationship: many_to_one
  }
  join: campaign_info {
    sql_on: ${campaign_info.campaign_id} = ${view_tracking_event.campaign_id} ;;
    relationship: many_to_one
  }
  join: jg_info {
    sql_on: ${jg_info.job_group_id} = ${view_tracking_event.job_group_id} ;;
    relationship: many_to_one
  }

}

view: jb_cnt {
  derived_table: {
    sql: with jb_count as (select agency_id,client_id,campaign_id,job_group_id,date,avg(sponsored_jobs_count) job_cnt from JOBS.MODELLED.HISTORICAL_JOB_COUNT group by agency_id,client_id,campaign_id,job_group_id,date)
select row_number() OVER(order by 1) AS prim_key,* from jb_count ;;
  }
  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.prim_key;;
  }
  dimension: agency_id {
    type: string
    sql: ${TABLE}.agency_id ;;
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
    sql: ${TABLE}.date ;;
  }
  dimension: job_cnt {
    type: number
    sql: ${TABLE}.job_cnt ;;
  }
 }

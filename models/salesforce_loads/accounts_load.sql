-- depends_on: {{ ref('omnata_push','sfdc_load_tasks') }}
-- depends_on: {{ ref('omnata_push','sfdc_load_task_logs') }}
{{
  config(
    materialized='load_task',
    operation='upsert',
    object_name='Account',
    external_id_field='AccountNumber__c'
  )
}}

select OBJECT_CONSTRUCT('Name',NAME,
        'AccountNumber__c',ACCOUNT_NUMBER) as RECORD
from {{ ref('accounts') }}




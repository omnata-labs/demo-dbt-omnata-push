-- depends_on: {{ ref('omnata_push','sfdc_load_tasks') }}
-- depends_on: {{ ref('omnata_push','sfdc_load_task_logs') }}
{{
  config(
    materialized='load_task',
    operation='upsert',
    object_name='Contact',
    external_id_field='ContactNumber__c'
  )
}}

select OBJECT_CONSTRUCT('FirstName',LAST_NAME,
        'LastName',FIRST_NAME,
        'ContactNumber__c',CONTACT_NUMBER,
        'Title',TITLE,
        'Email',EMAIL,
        'Account',OBJECT_CONSTRUCT('Account_Number__c',ACCOUNT_NUMBER)) as RECORD
from {{ ref('contacts') }}

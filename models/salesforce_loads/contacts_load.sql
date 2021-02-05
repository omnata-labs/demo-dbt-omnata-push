-- depends_on: {{ ref('omnata_push','sfdc_load_tasks') }}
-- depends_on: {{ ref('omnata_push','sfdc_load_task_logs') }}
{{
  config(
    materialized='load_task',
    operation='upsert',
    object_name='Contact',
    external_id_field='Contact_Number__c'
  )
}}

select OBJECT_CONSTRUCT('FirstName',LAST_NAME,
        'LastName',FIRST_NAME,
        'Contact_Number__c',CONTACT_NUMBER,
        'Title',TITLE,
        'Email',EMAIL,
        'Account',OBJECT_CONSTRUCT('Account_Number__c',ACCOUNT_NUMBER) as RECORD
from {{ ref('contacts') }}
where 1=1

{% if var('full-refresh-salesforce')==false %}

  -- this filter will only be applied on an incremental run, to prevent re-sync
  -- of previously successful records
  and RECORD:"Contact_Number__c"::varchar not in (
    select logs.RECORD:"Contact_Number__c"::varchar 
    from {{ ref('omnata_push','sfdc_load_task_logs') }} logs
    where logs.load_task_name= '{{ this.name }}'
    and logs.RESULT:"success" = true
  )
  
{% endif %}



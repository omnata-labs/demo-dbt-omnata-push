## Salesforce configuration required to support Omnata Push demo

1) Install SFDX (Salesforce CLI)

2) Auth to your Dev Hub and create a scratch org (henceforth aliased as 'dbt_demo_org'). Use your real email address as the admin email.

3) Configure the custom objects and fields:
```
sfdx force:apex:execute -u dbt_demo_org -f custom_objects_and_fields.apex
```

4) Reset scratch org credentials
```
sfdx force:user:password:generate -u dbt_demo_org
```
(make note of username and password)

5) Log in:
```
sfdx force:org:open -u dbt_demo_org
```

Reset the user's security token, check your email and make note of it.

6) Install Omnata from the AppExchange

7) Use the Omnata setup add to connect to Snowflake, then use the Salesforce credentials to generate an Omnata Push API key.

8) Run the provided API INTEGRATION and EXTERNAL FUNCTION snippets into Snowflake. The functions should go under the same schema as your dbt target schema, and you should grant usage on them to your dbt role(s).

Now you can run the load tasks in this repo.

Afterwards when all finished, clean up the scratch org:
```
sfdx force:org:delete -u dbt_demo_org
```
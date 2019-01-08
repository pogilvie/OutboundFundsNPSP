### CCI Setup
1. Activate cci (after activation promple on unix machines should be prepended with 'cci')
````
pogilvie::~/Projects-> source cci/bin/activate
(cci) pogilvie::~/Projects->
````
2. Change directory to the local git repo
````
cci) pogilvie: (pogilvie-manage-disbursements-component):~/Projects/OutboundFunds/src/OutboundFundsNPSP->
````
3. List cci specified orgs
````
Checking the version!
An update to CumulusCI is available. Use pip install --upgrade cumulusci to update.
org             default  scratch  days     expired  config_name     username
--------------  -------  -------  -------  -------  --------------  -----------------------------
beta                     *        1                 beta
dev                      *        14 of 7  *        dev             test-ikjjaqweykgo@example.com
dev_namespaced           *        7                 dev_namespaced
feature                  *        1                 feature
release         *        *        13 of 1  *        release         test-cv15nn0uxuml@example.com
````
4. Set the default org to 'dev'
````
(cci) pogilvie: (pogilvie-manage-disbursements-component):~/Projects/OutboundFunds/src/OutboundFundsNPSP-> cci org default dev
Checking the version!
An update to CumulusCI is available. Use pip install --upgrade cumulusci to update.
dev is now the default org
````
5. Run info on dev org to spin it up
````
cci) pogilvie: (pogilvie-manage-disbursements-component):~/Projects/OutboundFunds/src/OutboundFundsNPSP-> cci org info dev
Checking the version!
2019-01-08 08:41:46: Creating scratch org with command sfdx force:org:create -f orgs/dev.json -n --durationdays 7 -a "OutboundFundsNPSP__dev"
2019-01-08 08:42:11: Successfully created scratch org: 00D3D0000009zt3UAA, username: test-fonej9bhwvwy@example.com
2019-01-08 08:42:11: Getting scratch org info from Salesforce DX
config_file: orgs/dev.json
days: 7
set_password: False
scratch: True
namespaced: False
config_name: dev
sfdx_alias: OutboundFundsNPSP__dev
default: True
scratch_org_type: workspace
org_id: 00D3D0000009zt3
username: test-fonej9bhwvwy@example.com
date_created: 2019-01-08 08:42:11.199740
created: True
instance_url: https://force-saas-7341-dev-ed.cs70.my.salesforce.com/
access_token: 00D3D0000009zt3!AQ8AQKPifK.80G7JFD._zUTdNByDiT1f5ROCqCcavyppBxQ6gj8VKic6QPYlcCqBCZOo49I5SpBEQSQ5LZDvV8wwUqdY6PGV
password: None
Org expires on Tue Jan 15 08:42:11 2019
````
6. Run the dev_org flow
````
````





## Questions

### blocking
- npsp__General_Accounting_Unit__c.Amount_Available__c field is visible in the Object Manager but rollup  summaries don't work and summary fields or fields that depend on summary fields are not visible to code.
- manage allocations visualforce page page and button is missing 

### annoyances
- NPSP opportunity record types are not installed
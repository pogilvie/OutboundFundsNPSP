
user = OutboundFundsNPSP__dev


# Describe variable Objects

all : component factory

open :
	sfdx force:org:open -u $(user)

setup :
	sfdx force:apex:execute -f ./src/apex/setup.apex -u$(user)

cleanup :
	sfdx force:apex:execute -f ./src/apex/cleanup.apex -u $(user)

query :
	sfdx force:data:soql:query -q 'select Id, Name from Account' -u $(user)
	sfdx force:data:soql:query -q 'select Id, Name from Opportunity' -u $(user)
	sfdx force:data:soql:query -q 'select Id, Name from Contact' -u $(user)
	sfdx force:data:soql:query -q 'select Id, Name from outfunds__Funding_Program__c' -u $(user)
	sfdx force:data:soql:query -q 'select Id, Name from outfunds__Funding_Request__c' -u $(user)
	sfdx force:data:soql:query -q 'select Id, Name from outfunds__Disbursement__c' -u $(user)
	sfdx force:data:soql:query -q 'select Id, Name, npsp__Description__c from npsp__General_Accounting_Unit__c' -u $(user)
	sfdx force:data:soql:query -q 'select Id, Name, npsp__Amount__c from npsp__Allocation__c' -u $(user)

allo_query = 'select Id, npsp__Amount__c, npsp__General_Accounting_Unit__r.Name, npsp__Opportunity__r.Name\
              from npsp__Allocation__c'
gau_query  = 'select Id, Name, npsp__Total_Allocations__c, npsp__Total_Number_of_Allocations__c\
              from npsp__General_Accounting_Unit__c'
query_gau :
	sfdx force:data:soql:query -q $(allo_query) -u $(user)
	sfdx force:data:soql:query -q $(gau_query) -u $(user)

test :
	sfdx force:apex:test:run -n Requirements -r human --wait 10 -u $(user)

desc_account : 
	sfdx force:schema:sobject:describe -s account -u $(user) |grep name:

desc_opportunity : 
	sfdx force:schema:sobject:describe -s opportunity -u $(user) |grep name:

GAU_Expendature :
	sfdx force:source:deploy -p ./src/objects/GAU_Expendature__c.object -u $(user)

deploy :
	sfdx force:mdapi:deploy -d ./deploysrc --wait 10 -u $(user)

gau :
	sfdx force:source:deploy -p ./src/objects/npsp__General_Accounting_Unit__c.object -u $(user)

component :
	sfdx force:source:deploy -p ./src/aura/outfundsnpsp_manangeDispersements

factory :
	sfdx force:source:deploy -p ./src/classes/Factory.cls -u $(user)

requirements :
	sfdx force:source:deploy -p ./src/classes/Requirements.cls -u $(user)








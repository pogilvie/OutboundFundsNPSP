
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

account : 
	sfdx force:schema:sobject:describe -s account -u $(user) |grep name:

opportunity : 
	sfdx force:schema:sobject:describe -s opportunity -u $(user) |grep name:

component :
	sfdx force:source:deploy -p ./src/aura/outfundsnpsp_manangeDispersements

factory :
	sfdx force:source:deploy -p ./src/classes/Factory.cls -u $(user)








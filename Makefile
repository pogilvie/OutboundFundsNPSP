
user = OutboundFundsNPSP__dev


# Describe variable Objects

account : 
	sfdx force:schema:sobject:describe -s account -u $(user) |grep name:

opportunity : 
	sfdx force:schema:sobject:describe -s opportunity -u $(user) |grep name:

factory :
	sfdx force:source:deploy -p ./src/classes/Factory.cls -u $(user)








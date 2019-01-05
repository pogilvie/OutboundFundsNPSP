public with sharing class manageDisbursementsController {
   
   @AuraEnabled public static outfundsnpspext__GAU_Expenditure__c[] get(Id disburementId) {

        if (!accessible())
            return null; 

        try {
            return [
                select Id, Name, outfundsnpspext__Amount__c 
                from outfundsnpspext__GAU_Expenditure__c 
                where outfundsnpspext__Disbursement__c = :disburementId
            ];
        } catch(Exception e) {
            return null;
        }

   }

   private static Boolean accessible() {

        return (
            Schema.sObjectType.outfunds__Disbursement__c.isAccessible() &&
            Schema.sObjectType.outfundsnpspext__GAU_Expenditure__c.fields.outfundsnpspext__Disbursement__c.isAccessible() &&
            Schema.sObjectType.outfundsnpspext__GAU_Expenditure__c.fields.outfundsnpspext__Amount__c.isAccessible() &&
            Schema.sObjectType.outfundsnpspext__GAU_Expenditure__c.fields.Name.isAccessible() &&
            Schema.sObjectType.outfundsnpspext__GAU_Expenditure__c.fields.Id.isAccessible()
        );

   }
}

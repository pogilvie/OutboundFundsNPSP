public with sharing class manageDisbursementsController {
   
   @AuraEnabled public static outfundsnpspext__GAU_Expenditure__c[] get(Id disburementId) {

        if (!accessible())
            return null; 

        try {
            return [
                select 
                    Id,
                    Name,
                    outfundsnpspext__General_Accounting_Unit__c,
                    outfundsnpspext__General_Accounting_Unit__r.Name,
                    outfundsnpspext__Amount__c
                from outfundsnpspext__GAU_Expenditure__c 
                where outfundsnpspext__Disbursement__c = :disburementId
            ];
        } catch(Exception e) {
            return null;
        }

    }

    @AuraEnabled public static Boolean set(
        outfundsnpspext__GAU_Expenditure__c[] inserts, 
        outfundsnpspext__GAU_Expenditure__c[] updates,
        outfundsnpspext__GAU_Expenditure__c[] deletes) 
    {

        try {

            if (inserts.size() > 0)
                insert inserts;
            
            if (updates.size() > 0)
                update updates;
            
            if (deletes.size() > 0)
                delete deletes;

        } catch (DmlException e) {
                
            for (Integer i = 0; i < e.getNumDml(); i++) {
                System.debug(e.getDmlMessage(i)); 
            }
            final String msg = 'DML operation failed to Expenditure: ' + e.getDmlMessage(0); 
            throw new AuraHandledException(msg);
        }

        return true;

    }
   
    private static Boolean accessible() {

        return (
            Schema.sObjectType.outfunds__Disbursement__c.isAccessible() &&
            Schema.sObjectType.outfundsnpspext__GAU_Expenditure__c.fields.outfundsnpspext__General_Accounting_Unit__c.isAccessible() &&
            Schema.sObjectType.outfundsnpspext__GAU_Expenditure__c.fields.outfundsnpspext__Disbursement__c.isAccessible() &&
            Schema.sObjectType.outfundsnpspext__GAU_Expenditure__c.fields.outfundsnpspext__Amount__c.isAccessible() &&
            Schema.sObjectType.outfundsnpspext__GAU_Expenditure__c.fields.Name.isAccessible() &&
            Schema.sObjectType.outfundsnpspext__GAU_Expenditure__c.fields.Id.isAccessible()
        );
        
   }
}

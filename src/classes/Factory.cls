public with sharing class Factory {

    public static Id createAccount(String name) {

        Account a = new Account(
            Name = name
        );
        insert a;

        return a.Id;

    }

    public static Id createOpportunity(Id accountId, String name, String closeDate, Decimal amount, String stage) {

        String[] parts = closeDate.split('-');
        Integer year, month, day;

        year = Integer.valueOf(parts[0]);
        month = Integer.valueOf(parts[1]);
        day = Integer.valueOf(parts[2]);
        
        Opportunity o = new Opportunity(
            AccountId = accountId,
            Name = name,
            CloseDate = Date.newInstance(year, month, day),
            Amount = amount,
            StageName = stage
        );
        insert o;

        return o.Id;
    }

    public static Id createContact(Id accountId, String firstName, String lastName) {

        Contact c = new Contact(
            AccountId = accountId,
            FirstName = firstName,
            LastName = lastName
        );
        insert c;

        return c.Id;
    }

    public static Id createFundingProgram(String name, String description) {

        outfunds__Funding_Program__c fp = new outfunds__Funding_Program__c(
            Name = name,
            outfunds__Description__c = description,
            outfunds__Start_Date__c = Date.today(),
            outfunds__End_Date__c = Date.today().addYears(1),
            outfunds__Funding_Program_Manager__c = UserInfo.getUserId(),
            outfunds__Status__c = 'In progress',
            outfunds__Total_Program_Amount__c = 10000
        );
        insert fp;

        return fp.Id;

    }

    public static void setup() {

        Id gatesFoundationId = createAccount('Gates Foundation');
        
        Id gatesGrantId = createOpportunity(
            gatesFoundationId, 
            'Gates Fundation Grant 2019',
            '2018-12-01',
            1000.5,
            'Closed Won'
        );

        Id billGatesId = createContact(
            gatesFoundationId,
            'Bill', 'Gates'
        );

        Id fundingProgramId = createFundingProgram(
            'Malaria', 'Malaria Funding Program'
        );
       
    }

    public static void cleanup() {
        delete [select Id from Opportunity];
        delete [select Id from Contact];
        delete [select Id from Account];
        delete [select Id from outfunds__Funding_Program__c];
    }
}

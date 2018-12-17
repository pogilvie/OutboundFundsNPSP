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

    public static void setup() {

        Id gatesFoundationId = createAccount('Gates Foundation');
        
        Id gatesGrant = createOpportunity(
            gatesFoundationId, 
            'Gates Fundation Grant 2019',
            '2018-12-01',
            1000.5,
            'Closed Won'
        );
       
    }

    public static void cleanup() {

        delete [select Id from Account];
        delete [select Id from Opportunity];
    }
}

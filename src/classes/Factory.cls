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

    public static Id createFundingRequest(String Name, Id who, Id fromOrg, Id program) {

        outfunds__Funding_Request__c fr = new outfunds__Funding_Request__c(
            Name = name,
            outfunds__Applying_Contact__c = who,
            outfunds__Applying_Organization__c = fromOrg,
            outfunds__Funding_Program__c = program,
            outfunds__Requested_Amount__c = 10000,
            outfunds__Recommended_Amount__c = 9000,
            outfunds__Requested_For__c = 'Malaria Research',
            outfunds__Status__c = 'Awarded',
            outfunds__Population_Served__c = 'outfunds__Population_Served__c',
            outfunds__Application_Date__c = Date.today().addMonths(-1),
            outfunds__Close_Date__c = Date.today(),
            outfunds__Term_Start_Date__c = Date.today(),
            outfunds__Term_End_Date__c = Date.today().addYears(1),
            outfunds__Awarded_Date__c = Date.today().addDays(-7)
        );
        insert fr;

        return fr.Id;
    }

    public static Id createDisbursment(Id request) {

        outfunds__Disbursement__c d = new outfunds__Disbursement__c(
            outfunds__Funding_Request__c = request,
            outfunds__Amount__c = 100,
            outfunds__Disbursement_Date__c = Date.today(),
            outfunds__Disbursement_Method__c = 'Check',
            outfunds__Type__c = 'Initial'

        );
        insert d;

        return d.Id;
    }

    public static Id createGAU(String name, String description) {

        npsp__General_Accounting_Unit__c gau = new npsp__General_Accounting_Unit__c(
            Name = name,
            npsp__Description__c = description,
            npsp__Active__c = true
        );
        insert gau;

        return gau.Id;
    }

    public static Id createGAUAllocation(Id oppt, Id gau, Decimal amt) {

        npsp__Allocation__c allocation = new npsp__Allocation__c (
            npsp__Opportunity__c = oppt,
            npsp__General_Accounting_Unit__c = gau,
            npsp__Amount__c = amt
        );
        insert allocation;

        return allocation.Id;
    }

    public static void setup() {

        /* Accounts
        */
        Id gatesFoundationId = createAccount('Gates Foundation'),
        malariaResearchLabId = createAccount('Malaria Research Lab');
        
        /* Opportunity (in bound funds)
        */
        Id gatesGrantId = createOpportunity(
            gatesFoundationId, 
            'Gates Fundation Grant 2019',
            '2018-12-01',
            1000.5,
            'Closed Won'
        );

        /* Contacts
        */
        Id billGatesId = createContact(
            gatesFoundationId,
            'Bill', 'Gates'
        );
        Id MalariaResearcherId = createContact(
            malariaResearchLabId, 'Dr', 'Researcher'
        );

        /* Funding Program
        */
        Id fundingProgramId = createFundingProgram(
            'Malaria', 'Malaria Funding Program'
        );

        /* Funding Request
        */
        Id fundingRquestId = createFundingRequest(
            'New Malaria Research',
            MalariaResearcherId,
            malariaResearchLabId,
            fundingProgramId
        );

        /* Disbursment
        */
        Id disbusrsement = createDisbursment(fundingRquestId);

        /* GAU
        */
        Id gau = createGAU('Malaria GAU', 'Fund targeted specifically for Malaria research');

        /* GAU Allocation
        */
        Id allo = createGAUAllocation(gatesGrantId, gau, 1000.5);

       
    }

    public static void cleanup() {
        delete [select Id from Opportunity];
        delete [select Id from outfunds__Funding_Program__c];
        delete [select Id from outfunds__Funding_Request__c];
        delete [select Id from Account];
        delete [select Id from Contact];
        delete [select Id from outfunds__Disbursement__c];
        delete [select Id from npsp__General_Accounting_Unit__c];
    }
}

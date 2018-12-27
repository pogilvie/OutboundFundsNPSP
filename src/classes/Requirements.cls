/** 
 * @author       : Peter Ogilvie code@ogilvie.us.com
 * @date         : 2018-12-36
 * @descripttion : Test apex controller and required environment for GAU 
 *                 Expenditure management component 
 */
@IsTest public with sharing class Requirements {


    @TestSetup static void setup() {

        Factory.setup();
        
    }
    
    /**
     * @description : Verify NPSP rollups on GAU
     * given        : a valid instance of npsp__General_Accounting_Unit__c with
     *                a related insance of npsp__Allocation__c allocating funds
     *                to the GAU
     * expect       : Amount_Available__c > 0
     *                npsp__Total_Number_of_Allocations__c > 0
     */
     @isTest static void GAURollups () {

         Opportunity o = [
            select
                Id, 
                Amount 
            from Opportunity
        ];
         npsp__General_Accounting_Unit__c gau = [
            select 
                Id, 
                Amount_Available__c, 
                npsp__Total_Number_of_Allocations__c
            from npsp__General_Accounting_Unit__c
        ];
        npsp__Allocation__c allo = [
            select
                Id, 
                npsp__Amount__c,
                npsp__Opportunity__c,
                npsp__General_Accounting_Unit__c
            from npsp__Allocation__c
        ];

        System.assertEquals(gau.Id, allo.npsp__General_Accounting_Unit__c);
        System.assertEquals(o.Id, allo.npsp__Opportunity__c);
        System.assert(o.Amount > 0, 'Opportunity amount should be greater than 0');
        System.assert(gau.Amount_Available__c > 0, 'GAU amount should be greater than 0');
        System.assert(gau.npsp__Total_Number_of_Allocations__c > 0, 'Number of GAU allocations should be more then 0');

     }

    /**
     * @description : Cover Factory code.  The factory is used outside the
     *                The test to generate a known data set to develop on. 
     *                Factory.setup() is run automatically by Requirements.setup()
     *                This should be the last test or tests which depend on setup 
     *                will fail.
     */
    @IsTest static void coverFactory() {
        Factory.cleanup();
    }
}

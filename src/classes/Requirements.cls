@IsTest public with sharing class Requirements {


    @TestSetup static void setup() {

        Factory.createAccount('Gates Foundation');
        
    }

    @IsTest static void coverFactory() {
        Factory.setup();
        Factory.cleanup();
    }

    @IsTest static void one() {

        Account gatesFoundation = [select Id from Account];

        System.debug(gatesFoundation.Id);
        System.assertNotEquals(null, gatesFoundation.Id);
      
    }
}

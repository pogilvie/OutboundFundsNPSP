({
    disbursementUpdated : function(cmp, event, helper) {
        console.log('disbursementUpdated called');
        helper.loadExpenditures(cmp);
    },
    newExpenditure : function(cmp, event, helper) {

        const
            expenditures = cmp.get('v.expenditures');  

        console.log('newExpenditure called');

        expenditures.push({
            Id: '',
            Name: '',
            outfundsnpspext__Amount__c: 0,
            outfundsnpspext__General_Accounting_Unit__c: ''
        });

        cmp.set('v.expenditures', expenditures)
    },
    save : function(cmp, event, helper) {
        console.log('save');
    },
    cancel : function(cmp, event, helper) {
        console.log('cancel');
    }
})

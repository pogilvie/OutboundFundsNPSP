({
    doInit : function(cmp, event, helper) {
        console.log('manage doInit called');
        cmp.set('v.allocated', 10);
        cmp.set('v.remaining', 100);
    },
    disbursementUpdated : function(cmp, event, helper) {
        
        if (event.getParams().changeType === 'LOADED') {
            const d = cmp.get('v.disbursement');
            console.log(`loaded: ${d.Name} Id: ${d.Id} Amount: ${d.outfunds__Amount__c}`)
            helper.loadExpenditures(cmp);
        }

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
    },
    exChange : function(cmp, event, helper) {
        console.log('exChange old value: ' + JSON.stringify(event.getParam('oldValue')));
        console.log('exChange current value: ' + JSON.stringify(event.getParam('value')));
    }
})

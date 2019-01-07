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
            expenditures = cmp.get('v.expenditures2');  

        console.log('newExpenditure called');

        expenditures.push({
               Id : '',
             Name : '',
            gauId : '',
          gauName : '',
           amount : 0,
          changed : false,
            valid : false
        });

        cmp.set('v.expenditures2', expenditures);

        console.log('newExpenditure done');
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
    },
    handleUpdate : function(cmp, event, helper) {
        const
            index = event.getParam('index'),
            amount = event.getParam('amount'),
            opcode = event.getParam('opcode'),
            expenditures = cmp.get('v.expenditures2');
        let
            change = false,
            remaining = 0,
            totalAmount = 0;

        console.log('handleUpdate opcode: ' + opcode);
        console.log('handleUpdate index: ' +  index);
        console.log('handleUpdate amount: ' + amount);

        if (opcode === 'delete') {
            expenditures.splice(index, 1);
        }

        expenditures.forEach(function(e, i) {
            console.log('e.amount ' + e.amount)
            totalAmount += Number(e.amount);

            if (opcode === 'update' && i === index) {
                console.log('setting amount')
                e.amount = amount;
                change = true;
            }
        });
        console.log('handleUpdate ' + totalAmount);
        cmp.set('v.allocated', totalAmount);

        remaining = cmp.get('v.disbursement.outfunds__Amount__c') - totalAmount;
        cmp.set('v.remaining', remaining);

        cmp.set('v.expenditures2', expenditures);

        if (change) 
            remaining >= 0 ? cmp.set('v.saveDisabled', false) :  cmp.set('v.saveDisabled', true);
    }
})

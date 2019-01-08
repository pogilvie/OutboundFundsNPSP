({
    doInit : function(cmp, event, helper) {
        const
            amount = cmp.get('v.lineItem.amount'),
            dispTotal = cmp.get('v.dispTotal');

        cmp.set('v.gau', {
            val: cmp.get('v.lineItem.gauId'),
            text: cmp.get('v.lineItem.gauName'),
        objName: 'npsp__General_Accounting_Unit__c'
        });

        console.log('row doInit: ', amount, dispTotal)

        if (dispTotal > 0)
            cmp.set('v.percent', (amount/dispTotal));
        else
            cmp.set('v.percent', 0);
    },
    handleAmount : function(cmp, event, helper) {
        const
            amount = cmp.get('v.lineItem.amount'),
            dispTotal = cmp.get('v.dispTotal');

        if (amount <= 0) {
            cmp.set('v.invalidAmount', true);
            return;
        }

        cmp.set('v.invalidAmount', false);

        try {
            let ev = cmp.getEvent('update');
        
            console.log('handleAmount: ' + amount);
        
            if (dispTotal > 0) {
                cmp.set('v.percent', amount/dispTotal);
                cmp.set('v.lineItem.changed', true);
            }

            ev.setParams({
               opcode: 'update',
                index: cmp.get('v.index'), 
               amount: cmp.get('v.lineItem.amount')
            });
            ev.fire();

            console.log('handleAmount done');
        } catch (error) {
            console.log('handleAmount:' + error)
        }
        
            
    },
    handlePercent : function(cmp, event, helper) {
        const
            fraction = cmp.get('v.percent'),
            dispTotal = cmp.get('v.dispTotal');

        if (fraction > 1 || fraction <= 0) {
            cmp.set('v.invalidPercent', true);
            return;
        }

        cmp.set('v.invalidPercent', false)

        let
            ev = cmp.getEvent('update'),
            amount = dispTotal * fraction;

        cmp.set('v.lineItem.amount', amount);

        ev.setParams({
            opcode: 'update',
             index: cmp.get('v.index'), 
            amount: amount,
             gauid: cmp.get('v.gua.val')
        });
        ev.fire();

        cmp.set('v.lineItem.changed', true);

        console.log('handlePercent Done');
    },
    handleLookup : function(cmp, event, helper) {
        const
            ev = cmp.getEvent('update'),
            index = cmp.get('v.index');

        console.log(`index ${index} gau old value: ` + JSON.stringify(event.getParam('oldValue')));
        console.log(`index ${index} gau current value: ` + JSON.stringify(event.getParam('value')));

        // ev.setParams({
        //     opcode: 'gau',
        //     index: index,
        //     gauid: event.getParam('value').val

        // });
        // ev.fire();
    },
    doDelete : function(cmp, event, helper) {
        console.log('doDelete called');
        const ev = cmp.getEvent('update');

        ev.setParams({
            opcode: 'delete',
            index: cmp.get('v.index')
        });
        ev.fire();
    }
})

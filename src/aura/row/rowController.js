({
    doInit : function(cmp, event, helper) {
        const
            amount = cmp.get('v.lineItem.amount'),
            dispTotal = cmp.get('v.dispTotal');

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
                amount:cmp.get('v.lineItem.amount')
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

        cmp.set('v.lineItem.amount', dispTotal * fraction);
        cmp.set('v.lineItem.changed', true);

        console.log('handlePercent');
    },
    handleLookup : function(cmp, event, helper) {
        console.log('selectedIem has changed');
        console.log('old value: ' + JSON.stringify(event.getParam('oldValue')));
        console.log('current value: ' + JSON.stringify(event.getParam('value')));
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

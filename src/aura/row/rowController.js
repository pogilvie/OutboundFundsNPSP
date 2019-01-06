({
    doInit : function(cmp, event, helper) {
        const
            amount = cmp.get('v.amount'),
            dispTotal = cmp.get('v.dispTotal');

        console.log('row doInit: ', amount, dispTotal)

        if (dispTotal > 0)
            cmp.set('v.percent', (amount/dispTotal));
        else
            cmp.set('v.percent', 0);
    },
    handleAmount : function(cmp, event, helper) {
        const
            amount = cmp.get('v.amount'),
            dispTotal = cmp.get('v.dispTotal');
        
        cmp.set('v.percent', amount/dispTotal);

        console.log('handleAmount called');
            
    },
    handlePercent : function(cmp, event, helper) {
        const
            fraction = cmp.get('v.percent'),
            dispTotal = cmp.get('v.dispTotal');

        cmp.set('v.amount', dispTotal * fraction);

        console.log('handlePercent');
    },
    handleLookup : function(cmp, event, helper) {
        console.log('selectedIem has changed');
        console.log('old value: ' + JSON.stringify(event.getParam('oldValue')));
        console.log('current value: ' + JSON.stringify(event.getParam('value')));
    }
})

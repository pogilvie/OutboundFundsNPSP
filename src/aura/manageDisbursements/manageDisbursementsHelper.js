({
    loadExpenditures : function(cmp) {
        const action = cmp.get('c.get');

        action.setParams({ disburementId: cmp.get('v.recordId')});

        action.setCallback(this, function(r) {

            if (r.getState() === 'SUCCESS') {
                console.log(r.getReturnValue());
                cmp.set('v.expenditures', r.getReturnValue());
            } else {
                console.log('load Expenditures failed ', r.getError());
            }

        });

        $A.enqueueAction(action);
    }
})
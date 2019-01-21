({
    loadExpenditures : function(cmp) {
        const action = cmp.get('c.get');

        action.setParams({ disburementId: cmp.get('v.recordId')});

        action.setCallback(this, function(r) {

            if (r.getState() === 'SUCCESS') {
                console.log('loadExpenditures', r.getReturnValue());
                
                let 
                    totalAllocated = 0,
                    exOut = [];
                const 
                    exps = r.getReturnValue();

                exps.forEach(function(e) {
                    totalAllocated += e.outfundsnpspext__Amount__c;
                    exOut.push({
                             Id : e.Id,
                           Name : e.Name,
                          gauId : e.outfundsnpspext__General_Accounting_Unit__c,
                        gauName : e.outfundsnpspext__General_Accounting_Unit__r.Name,
                         amount : e.outfundsnpspext__Amount__c,
                        changed : false,
                          valid : true
                    });
                });

                cmp.set('v.allocated', totalAllocated);
                cmp.set('v.remaining', 
                    cmp.get('v.disbursement.outfunds__Amount__c') - totalAllocated);

                try {
                    cmp.set('v.expenditures', exps);
                } catch (error) {
                    console.log('error setting expenditures:', error);
                }

                cmp.set('v.expenditures2', exOut);
                console.log('loadExpenditures done');
                
            } else {
                console.log('loadExpenditures failed ', r.getError());
            }

        });

        $A.enqueueAction(action);
    },
    saveExpenditures : function(cmp) {
        const
            inserts = [], updates = [], deletes = [],
            expenditures = cmp.get('v.expenditures2'),
            action = cmp.get('c.set');

        expenditures.forEach(function(e) {

            if (!e.Id) {
                inserts.push({
                    outfundsnpspext__Disbursement__c: cmp.get('v.recordId'),
                    outfundsnpspext__Amount__c: e.amount,
                    outfundsnpspext__General_Accounting_Unit__c: e.gauId
                })
            }

            if (e.changed && e.Id) {
                updates.push({
                    Id: e.Id,
                    outfundsnpspext__Amount__c: e.amount,
                    outfundsnpspext__General_Accounting_Unit__c: e.gauId
                })
            }
        });

        action.setParams({
            inserts: deletes,
            updates: updates,
            deletes: deletes
        });

        action.setCallback(this, function(r) {

            if (r.getState() === 'SUCCESS') {
                console.log('saveExpenditures', r.getReturnValue());

                this.showToast('Save', 'Save Expenditures complete');

                cmp.set('v.saveDisabled', true);

            } else {
                console.log('saveExpenditures failed ', r.getError());
            }

        });

        console.log(inserts);

        $A.enqueueAction(action);

    },
    showToast : function(title, msg) {
        const ev = $A.get('e.force:showToast');
        ev.setParams({
            title: title,
            message: msg,
            type: 'success'
        });
        ev.fire();
    }
    
})
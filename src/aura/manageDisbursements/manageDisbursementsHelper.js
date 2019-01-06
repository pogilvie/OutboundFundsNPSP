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
                         amount : e.outfundsnpspext__Amount__c,
                        changed : false,
                          valid : true
                    });
                });

                cmp.set('v.allocated', totalAllocated);
                cmp.set('v.remaining', 
                    cmp.get('v.disbursement.outfunds__Amount__c') - totalAllocated);

                try  {
                    cmp.set('v.expenditures', exps);
                } catch (error) {
                    console.log('error setting expenditures:', error);
                }

                cmp.set('v.expenditures2', exOut);
                console.log('loadExpenditures done');
                
            } else {
                console.log('load Expenditures failed ', r.getError());
            }

        });

        $A.enqueueAction(action);
    }
    
})
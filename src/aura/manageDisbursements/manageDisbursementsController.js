({
    disbursementUpdated : function(cmp, event, helper) {
        console.log('disbursementUpdated called');
        helper.loadExpenditures(cmp);
    }
})

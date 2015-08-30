trigger akUpdateAccountTrigger on Contact (after update) {
    for (Contact cct : Trigger.new) {
       
        // Access the "old" record by its ID in Trigger.oldMap
        Contact oldcct = Trigger.oldMap.get(cct.Id);
    
        String updAccountId = cct.AccountId;
        Decimal oldFunnelStage = oldcct.FunnelStageInt__c;
        Decimal newFunnelStage = cct.FunnelStageInt__c;
        
        if (newFunnelStage > oldFunnelStage){
//          System.debug('The Contact Stage has Improved');
            akUpdateAccount a = new akUpdateAccount();
            a.UpdateAccountRel(updAccountId,newFunnelStage);
        }
        
        else {
//          System.debug('The Contact Stage has Not Improved');            
        }
        
    }
}
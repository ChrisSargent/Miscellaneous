public class akUpdateAccount {
    public void UpdateAccountRel(String updAccountId, Decimal newFunnelStage){
        Account updAccount = [SELECT Id, Name, Account_Relationship__c, AccRelationshipInt__c FROM Account WHERE Id = :updAccountId];

        Decimal updAccountStage = updAccount.AccRelationshipInt__c;
        String oldRel = updAccount.Account_Relationship__c;
        String newRel;
        
        if (newFunnelStage > updAccountStage){
        	if (newFunnelStage == 1){
        		newRel = 'Contacted';
        	}
        	else if (newFunnelStage == 2){
        		newRel = 'Responded';
        	}
        	else if (newFunnelStage == 3){
        		newRel = 'Qualified Lead';
        	}
        	else if (newFunnelStage == 4){
        		newRel = 'Active Account';
        	}
        	else {
        		newRel = oldRel;
        	}
			updAccount.Account_Relationship__c = newRel;
            update updAccount;
//          System.debug('I updated ' + updAccount.Name + ' with ID ' + updAccountId + ' to ' + newRel);            
        }
        
        else{
//	        System.debug('Account Relationship was not Improved, hence no change.');            
        }
    }
}
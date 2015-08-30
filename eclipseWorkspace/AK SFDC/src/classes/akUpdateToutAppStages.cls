public class akUpdateToutAppStages {
    
    public void processStage(String newSalesStage, String[] emailToList){
                
        String currentSalesStage;
        
        // Select a list of contacts from the database whose email address matches
        List<Contact> EmailMatches = [SELECT Id, Name, ToutApp_Sales_Stage__c FROM Contact WHERE Email = :emailToList];
        
        if (EmailMatches.size() > 0){
            // Loop through the list of contacts and update the MarketingCampaign field
            for(Contact c : EmailMatches){
                currentSalesStage = c.ToutApp_Sales_Stage__c; // Stores the current value of Sales Campaign
                if (newSalesStage == null) newSalesStage = currentSalesStage; // If the new value is blank then it keeps the old value
                c.ToutApp_Sales_Stage__c = newSalesStage;
                System.debug('Updated Marketing Campaign Field for ' + c.Name );
            }
            
            // Update the Contact record
            update EmailMatches;
         }      
        
        else {
            System.debug('No Matching Email Addresses Found');
        }

    }
}
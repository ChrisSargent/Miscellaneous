trigger AK_updLeadFromCB on Lead (before insert, before update) {
for (Lead lead: Trigger.new)
    {
    string countryFromLookup;
    string regionFromLookup;
    string territoryFromLookup;
    decimal funding = lead.CB_Funding_Total_USD__c;
    integer foundedYear;
    string CBCategories = lead.CB_Category_List__c;

// Checks if the Crunchbase Country Code is filled in
    if (lead.CB_Country_Code__c == null){
        lead.Region__c = null;
        lead.Akascia_Territory__c = null;
        lead.Country = null;
        }
        
// Updates the Region, Akascia Territory and Country field based on the values in the Custom Setting
    else{
        try{
            ISO_alpha3_Country_Code__c ISO3 = ISO_alpha3_Country_Code__c.getInstance(lead.CB_Country_Code__c);        
//          system.debug(ISO3);
            lead.Country = countryFromLookup = ISO3.Country_Name__c;
            lead.Region__c = regionFromLookup = ISO3.Region__c;
            lead.Akascia_Territory__c = territoryFromLookup = ISO3.Akascia_Territory__c;
            if (territoryFromLookup == 'Outside'){
                lead.Status = 'Non-Target';
                lead.Non_Target_Auto_or_Manual__c = 'Auto';
                }
            }
        catch (System.NullPointerException e){
            lead.addError('The Country Code was not found in the Custom Settings Lookup, the record was not updated.');
            }
        }

// Checks the funding level of the company based on it's region and selects True or False for the Check Funding Field and sets the Lead Status if non-target    
        if (funding >= 7000000 && regionFromLookup == 'Americas'){
            lead.Check_Funding__c = true;
            }
        else if (funding >= 2000000 && regionFromLookup != 'Americas'){
            lead.Check_Funding__c = true;
            }
        else if (funding == null){
            lead.Check_Funding__c = true;
            }
        else{
            lead.Check_Funding__c = false;
            lead.Status = 'Non-Target';
            lead.Non_Target_Auto_or_Manual__c = 'Auto';
            }

// Checks the founding year of the company and selects True or False for the Check Age Field and sets the Lead Status if non-target
        if (lead.CB_Founded_Year__c == null){
            foundedYear = null;
            }
        else{
            foundedYear = integer.valueof(lead.CB_Founded_Year__c); 
            }
         
        if (foundedYear >=2005 || foundedYear == null){
            lead.Check_Age__c = true;
            }
        else{
            lead.Check_Age__c = false;
            lead.Status = 'Non-Target';
            lead.Non_Target_Auto_or_Manual__c = 'Auto';
            }

// Checks the Category List of the company to check if it's on the the Technology Blacklist custom setting
        if (CBCategories == null){
            lead.Check_Technology__c = true;
            }
            
        else{
            if (CBCategories.startsWith('\\|') == true){
                CBCategories = CBCategories.substring(1,0);
                }
            if (CBCategories.endsWith('\\|') == true){                        
                CBCategories = CBCategories.substring(0,CBCategories.length()-1);
                }
                
            list<string> CBCategoriesList = CBCategories.split(',|\\|');        
//          system.debug(CBCategoriesList);
    
            for (string CBcategory : CBCategoriesList) {
                try{
                    Tech_Blacklist__c tech = Tech_Blacklist__c.getInstance(CBcategory);        
                    if (tech == null){
                        lead.Check_Technology__c = true;
//                      system.debug(tech);
                        }
                    else{
                        lead.Check_Technology__c = false;
                        lead.Status = 'Non-Target';
                        lead.Non_Target_Auto_or_Manual__c = 'Auto';
                        }
                    }
                catch (System.NullPointerException e){
                    lead.addError('There was an error with the CB Categories List');
                    }
                }
            }
    }
}
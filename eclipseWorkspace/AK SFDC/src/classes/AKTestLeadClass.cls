@isTest 
private class AKTestLeadClass {
    static testMethod void AK_updLeadFromCB() {
       ISO_alpha3_Country_Code__c cCode = new ISO_alpha3_Country_Code__c(Name='USA', Region__c='Americas', Akascia_Territory__c='Americas');
       Lead ld = new Lead(LastName='CEO', Company='TestCompany', CB_Country_Code__c='USA', CB_Founded_Year__c='2005', CB_Funding_Total_USD__c=2000000);

       // Insert lead and ISO Country Custom Setting
       insert cCode;
       insert ld;
    
       // Retrieve the new lead
       ld = [SELECT Check_Age__c, Check_Funding__c, Region__c, Akascia_Territory__c, Status FROM Lead WHERE Id =:ld.Id];

       // Test that the trigger correctly updated the lead
       System.assertEquals(true, ld.Check_Age__c);
       System.assertEquals(false, ld.Check_Funding__c);
       System.assertEquals('Americas', ld.Region__c);
       System.assertEquals('Americas', ld.Akascia_Territory__c);
       
    }
}
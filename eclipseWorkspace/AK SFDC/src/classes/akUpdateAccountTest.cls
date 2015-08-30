@isTest 
private class akUpdateAccountTest {
    static testMethod void akUpdateAccountRelTest() {
		// Setup and Insert Test Account
		Account testAcct = new Account(Name='Test Account', Account_Relationship__c='', BillingCity='Test', BillingCountryCode='GB');
	    insert testAcct;
        ID testAcctID = testAcct.Id;

        // Setup and Insert Test Contact
        Contact testContact = new Contact(LastName='TestContact', FirstName='TestContactF', Funnel_Stage__c='', MailingCountryCode='GB', AccountId=TestAcctID);
        insert testContact;
        ID testContactID = testContact.Id;
        
        // Test the Account Relationship is Blank
		testAcct = [SELECT Id, Account_Relationship__c FROM Account WHERE Id = :testAcctID];
        System.assertEquals(null, testAcct.Account_Relationship__c);

        // Retrieve the Test Contact and update Funnel Stage Field on Test Contact
        testContact = [SELECT Id, Funnel_Stage__c FROM Contact WHERE Id = :testContactID];
        testContact.Funnel_Stage__c = 'To Contact';
        update testContact;
        
        // Test the Account Relationship is Blank
		testAcct = [SELECT Id, Account_Relationship__c FROM Account WHERE Id = :testAcctID];
        System.assertEquals(null, testAcct.Account_Relationship__c);
        
        // Retrieve the Test Contact and update Funnel Stage Field on Test Contact
        testContact = [SELECT Id, Funnel_Stage__c FROM Contact WHERE Id = :testContactID];
        testContact.Funnel_Stage__c = 'Contacted';
        update testContact;
		        
        // Test the Account Relationship has changed to Contacted
		testAcct = [SELECT Id, Account_Relationship__c FROM Account WHERE Id = :testAcctID];
        System.assertEquals('Contacted', testAcct.Account_Relationship__c);

        
        // Retrieve the Test Contact and update Funnel Stage Field on Test Contact
        testContact = [SELECT Id, Funnel_Stage__c FROM Contact WHERE Id = :testContactID];
        testContact.Funnel_Stage__c = 'Responded';
        update testContact;
		        
        // Test the Account Relationship has changed to Responded
		testAcct = [SELECT Id, Account_Relationship__c FROM Account WHERE Id = :testAcctID];
        System.assertEquals('Responded', testAcct.Account_Relationship__c);

        // Retrieve the Test Contact and update Funnel Stage Field on Test Contact
        testContact = [SELECT Id, Funnel_Stage__c FROM Contact WHERE Id = :testContactID];
        testContact.Funnel_Stage__c = 'Qualified';
        update testContact;
        
        // Test the Account Relationship has changed to Qualified Lead
		testAcct = [SELECT Id, Account_Relationship__c FROM Account WHERE Id = :testAcctID];
        System.assertEquals('Qualified Lead', testAcct.Account_Relationship__c);

		// Retrieve the Test Contact and update Funnel Stage Field on Test Contact
        testContact = [SELECT Id, Funnel_Stage__c FROM Contact WHERE Id = :testContactID];
        testContact.Funnel_Stage__c = 'Customer';
        update testContact;
        
        // Test the Account Relationship has changed to Active Account
		testAcct = [SELECT Id, Account_Relationship__c FROM Account WHERE Id = :testAcctID];
        System.assertEquals('Active Account', testAcct.Account_Relationship__c);
        
		// Retrieve the Test Contact and update Funnel Stage Field on Test Contact
        testContact = [SELECT Id, Funnel_Stage__c, FunnelStageInt__c FROM Contact WHERE Id = :testContactID];
        testContact.Funnel_Stage__c = 'Contacted';
        update testContact;
        
        // Test the Account Relationship has not changed
		testAcct = [SELECT Id, Account_Relationship__c FROM Account WHERE Id = :testAcctID];
        System.assertEquals('Active Account', testAcct.Account_Relationship__c);

    }
}
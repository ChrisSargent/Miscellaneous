@isTest
private class akProcessInboundTest {
    static testMethod void akProcessInboundTest() {
        // create a new email and envelope object
         
        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();
       
        // setup the data for the email
        
        String[] TestToList = new String[] {'me@email1.com','you@email2.com'};
        email.toAddresses = TestToList;
        env.fromAddress = 'someaddress@email.com';
        email.subject = 'Congratulations on your recent funding';
                
        // call the class and test it with the data in the testMethod
        Test.startTest();
        akProcessInboundStageS1 s1 = new akProcessInboundStageS1();
        s1.handleInboundEmail(email, env);
      
        akProcessInboundStageS2 s2 = new akProcessInboundStageS2();
        s2.handleInboundEmail(email, env);

        akProcessInboundStageS3 s3 = new akProcessInboundStageS3();
        s3.handleInboundEmail(email, env);

        akProcessInboundStageS4 s4 = new akProcessInboundStageS4();
        s4.handleInboundEmail(email, env);

        akProcessInboundStageS5 s5 = new akProcessInboundStageS5();
        s5.handleInboundEmail(email, env);

        akProcessInboundStageS6 s6 = new akProcessInboundStageS6();
        s6.handleInboundEmail(email, env);

        akProcessInboundStageR1 r1 = new akProcessInboundStageR1();
        r1.handleInboundEmail(email, env);

        Test.stopTest();
    }
    static testMethod void UpdateToutAppTest() {     
    
        List<String> emailToList = new List<String>{'test1@email.com','test2@email.com'};
        String newSalesStage;
        
        newSalesStage = 'Stage 1';
        
        Contact newContact = new Contact(LastName='TestContact', FirstName='TestContactF', Email='test1@email.com', MailingCountryCode='GB', Funnel_Stage__c='To Contact');
        insert newContact;
        
        Test.startTest();
        akUpdateToutAppStages c = new akUpdateToutAppStages();
        c.processStage(newSalesStage, emailToList);        
        Test.stopTest();
    }
}
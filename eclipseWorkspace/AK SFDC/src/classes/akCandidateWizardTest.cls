@isTest
public with sharing class akCandidateWizardTest{
  
  static testMethod void test() {
    Contact myContact = new Contact(FirstName = 'TestName', LastName = 'TestLastName', OtherCountryCode = 'GB');
    Account a = new Account(Name = 'TestAccount', BillingCountryCode = 'GB', BillingCity = 'SFO');
    insert a;
    Opportunity o = new Opportunity(name = 'TestOpp', CloseDate = Date.Today(), StageName = 'Closed', AccountId = a.Id);
    insert o;
    ApexPages.StandardController sc = new ApexPages.standardController(myContact);
    akCandidateWizard  cnt = new akCandidateWizard (sc);
    cnt.next();
    cnt.back();
    akCandidateWizard.CKvp c = new akCandidateWizard.CKvp('s','s',true);
    cnt.ica.Opportunity__c = o.Id;
    cnt.saveContact();
  }
}
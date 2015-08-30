public class akCandidateWizard {

    public Contact theContact { get; set; }
    public IdentifiedCandidateAssociation__c ica { get; set; }
    public integer wizardState { get; set; }
    public boolean showAll { get; set; }
    public boolean oppAdded { get; set; }

    public akCandidateWizard(ApexPages.StandardController controller) {
        theContact = (Contact)controller.getRecord();
        theContact.RecordTypeId = '012b0000000Tq7T';
        ica = new IdentifiedCandidateAssociation__c();
        wizardState = 1;
        showAll = ApexPages.CurrentPage().getParameters().get('showAll') == 'true';
    }
            
    public void next() {
        wizardState++;
    }
    public void back() {
        wizardState--;
    }    
    
    public PageReference saveContact() {
        try {
            upsert theContact;
            
            if (oppAdded) {
                ica.Candidate_Name__c = theContact.Id;
                upsert ica;
            }
            
            return new PageReference('/' + theContact.Id);  
        }
        catch (Exception ex) {
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR, ex.getMessage()));
            return null;
        }
    }
    
    public class CKvp
    {
        public CKvp(string sKey, string sId, boolean bValue)
        {
            key = sKey;
            id = sId;
            value = bValue;
        }
        public string key { get; set; }
        public string id { get; set; }
        public boolean value { get; set; }
    }
}
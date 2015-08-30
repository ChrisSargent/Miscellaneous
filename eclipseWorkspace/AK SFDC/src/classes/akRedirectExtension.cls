public class akRedirectExtension {
    private String RecordTypeId, RecordTypeName;
    public akRedirectExtension(ApexPages.StandardController controller)
    {   
        Contact cnt = (Contact)controller.getRecord();
        RecordTypeId = cnt.RecordTypeId; 
        RecordTypeName = '';
        for(RecordType rt:[select id,name from recordtype where id = :recordtypeid])
            RecordTypeName = rt.name;
    }
    public boolean getRedirect()
    {   if(RecordTypeName=='Candidate')
            return false;
        return true;
    }
    public string getRecordTypeId()
    {   return RecordTypeId;
    }
 }
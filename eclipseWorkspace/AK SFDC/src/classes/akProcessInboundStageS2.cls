public class akProcessInboundStageS2 implements Messaging.InboundEmailHandler {
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env){
                
        // Create an InboundEmailResult object for returning the result of the Apex Email Service
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();        
        
        String [] emailToList = email.toAddresses;
        String newSalesStage;

        newSalesStage = 'Stage 2';
        
        akUpdateToutAppStages c = new akUpdateToutAppStages();
        c.processStage(newSalesStage, emailToList);
        
        return result;
    }
}
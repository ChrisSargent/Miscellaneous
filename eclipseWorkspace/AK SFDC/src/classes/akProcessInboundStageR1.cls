public class akProcessInboundStageR1 implements Messaging.InboundEmailHandler {
    public Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env){
                
        // Create an InboundEmailResult object for returning the result of the Apex Email Service
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();        
        
        String [] emailToList = email.toAddresses;
        String newSalesStage;
        
        newSalesStage = 'Responded & Stopped';

        akUpdateToutAppStages c = new akUpdateToutAppStages();
        c.processStage(newSalesStage, emailToList);
        
        return result;
    }
}
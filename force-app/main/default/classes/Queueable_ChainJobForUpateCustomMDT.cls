/**
*
*  Purpose          :	Queueable Job Class to have the logic to update "HTTPCalloutConfiguration__mdt" custom metadata type records.
*
*  Created Date     :  	04/18/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class Queueable_ChainJobForUpateCustomMDT extends QueueableChainJob implements Queueable
{
    String msg;
    
    public Queueable_ChainJobForUpateCustomMDT(String msg) 
    {
        this.msg = msg;
    }
    
    public void execute(QueueableContext context) 
    {
        system.debug('@@@@@ ChainedJob ForUpateCustomMDT msg is = '  + msg);
        
        //Create/Update custom metadata type record
        String deployId = CreateUpdateCustomMetadataTypeHandler.saveHTTPCalloutConfigurationHandler(Constants.HTTP_CALLOUT_NAME_TEST_METADATA);
        system.debug('@@@@@ deployId = '  + deployId);
        
        if(String.isNotBlank(deployId)) 
        {
            Batch_CreateWebServiceLogsViaSOAP bC = new Batch_CreateWebServiceLogsViaSOAP();
            bC.query = Constants.QUERY_GET_ALL_SCHOOLS_LIMIT_2;
            
            //Schedule the batch job run after 2 min
            String cronID = System.scheduleBatch(bC, Constants.BATCH_CREATE_WEB_SERVICE_LOGS + String.valueOf(System.now()), 2); 
            system.debug('@@@@@ cronID = '  + cronID);
        }
        /*
        //Implement Loose Coupling with Chainable Interface
        // Chain this job to next job by submitting the next job
        ID jobID = this.enqueueNextJob();
*/
    }
}
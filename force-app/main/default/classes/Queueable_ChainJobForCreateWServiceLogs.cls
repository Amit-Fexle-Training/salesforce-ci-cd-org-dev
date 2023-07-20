/**
*
*  Purpose          :	Queueable Job Class to make a standard REST API callout to create a new web service log record details.
						Using this framework - https://github.com/rahulmalhotra/HTTPCalloutFramework
*
*  Created Date     :  	04/17/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class Queueable_ChainJobForCreateWServiceLogs extends QueueableChainJob implements Queueable, Database.AllowsCallouts
{
	WebServiceLogsWrapper wServiceLogsWrapper;
    String msg;
    
    public Queueable_ChainJobForCreateWServiceLogs(WebServiceLogsWrapper wServiceLogsWrapper) 
    {
    	this.wServiceLogsWrapper = wServiceLogsWrapper;
    }
    
    public Queueable_ChainJobForCreateWServiceLogs(String msg) 
    {
    	this.msg = msg;
    }
    
    public Queueable_ChainJobForCreateWServiceLogs(WebServiceLogsWrapper wServiceLogsWrapper, String msg) 
    {
    	this.msg = msg;
        this.wServiceLogsWrapper = wServiceLogsWrapper;
    }
    
    public void execute(QueueableContext context) 
    {
        system.debug('@@@@@ ChainedJob msg is = '  + msg);
        system.debug('@@@@@ ChainedJob msg is wrapper = '  + this.wServiceLogsWrapper);
        
        //With Framework
        HTTPResponse response = StandardRESTAPICalloutsHelper.createWebServiceLogRecordWithWrapperDetails(wServiceLogsWrapper);
        system.debug('@@@@@ response = '  + response);
        
        Queueable_ChainJobForUpateCustomMDT nextJob = new Queueable_ChainJobForUpateCustomMDT(Constants.CHAR_CHAINED_JOB_2);
        System.enqueueJob(nextJob);
        
        //Implement Loose Coupling with Chainable Interface
        // Chain this job to next job by submitting the next job
        ID jobID = this.enqueueNextJob();
    }
}
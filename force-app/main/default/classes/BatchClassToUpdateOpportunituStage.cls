/*
* Purpose : Batch Class To Update Opportunity Stage To Closed Won When Amount >= 10000.
* 
* Created By : Amit Kumar
* 
* Created Date : 04/27/2023
* 
* Version : v_0.1 - created 
* 
*/ 
public without sharing class BatchClassToUpdateOpportunituStage implements Database.Batchable<sObject>, Database.Stateful, Schedulable
{
    public String log;
    public Database.QueryLocator Start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator('SELECT Id, Amount, StageName FROM Opportunity WHERE Amount >= 10000');
    }
    
    public void Execute(Database.BatchableContext bc,List<Opportunity> listOfOpportunity)
    {
        try
        {
            if(listOfOpportunity.size()>0)
            {
                List<Opportunity> listOfOpportunityToBeUpdated = new List<Opportunity>();
                for(Opportunity opp : listOfOpportunity)
                {
                    opp.StageName = 'Closed Won';
                    listOfOpportunityToBeUpdated.add(opp);
                }
                if(listOfOpportunityToBeUpdated.size()>0)
                {
                    Database.SaveResult[] srList = Database.update(listOfOpportunityToBeUpdated, false);
                    for(Database.SaveResult sr : srList)
                    {
                        if(!sr.isSuccess())
                        {
                            for(Database.Error err : sr.getErrors())
                            {
                                log = err.getStatusCode()+ ':' + err.getMessage();
                                System.debug(log);
                            }
                        }
                    }
                }
            }
        }
        Catch(Exception ex)
        {
            System.debug(ex.getMessage() + ' ' + ex.getCause());
        }
    }
    
    public void Finish(Database.BatchableContext bc)
    {
        /*Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] {'kumar01072000amit@gmail.com'});
        mail.setReplyTo('amit.kumar@fexle.com');
        mail.setSenderDisplayName('BatchClassToUpdateOpportunituStage - Batch Processing');
        mail.setSubject('BatchClassToUpdateOpportunituStage - Batch Process Completed');
        mail.setPlainTextBody('BatchClassToUpdateOpportunituStage - Batch Process has completed ' + log );
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });*/
        
        //FutureClassToGetAccountRecords.getAccountRecordsNotRelatedWithContacts();
        Datetime scheduleTime = System.now().addMinutes(2);
        System.schedule('Future job', '0 6 8 ? ? ? ?',new FutureClassToGetAccountRecords());
    }
    
    public void execute(SchedulableContext sc)
    {
        Database.executeBatch(new BatchClassToUpdateOpportunituStage(), 200);
        
    }
}
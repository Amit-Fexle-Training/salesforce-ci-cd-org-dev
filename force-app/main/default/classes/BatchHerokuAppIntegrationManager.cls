/**
*
*  Purpose          :	Helper Class for integration Using Batch Apex with Open Source Heroku App.
*
*  Created Date     :  	04/14/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class BatchHerokuAppIntegrationManager implements Database.Batchable<sObject>,Database.Stateful 
{
    
    public Set<Id> schoolsIds = new Set<Id>();
    String query;
    
    public BatchHerokuAppIntegrationManager(Set<Id> schoolIds)
    {
        this.schoolsIds = schoolIds;
        query = 'SELECT Id FROM School__c WHERE Id IN : schoolsIds';
    }
    
    public Database.QueryLocator start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<sObject> scope)
    {
        if(schoolsIds != null && schoolsIds.size() > 0)
        {
            HerokuAppIntegrationManager.makeHerokuAppCalloutAndUpdateUsers(schoolsIds);
        }
    }
    
    public void finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] {'kumar01072000amit@gmail.com'});
        mail.setReplyTo('amit.kumar@fexle.com');
        mail.setSenderDisplayName('BatchHerokuAppIntegrationManager - Batch Processing');
        mail.setSubject('BatchHerokuAppIntegrationManager - Batch Process Completed');
        mail.setPlainTextBody('BatchHerokuAppIntegrationManager - Batch Process has completed ');
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
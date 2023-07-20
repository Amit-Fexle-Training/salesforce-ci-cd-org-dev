/*
* Purpose : Batch Class To Create Task On Active Contacts
* 
* Created By : Amit Kumar
* 
* Created Date : 04/24/2023
* 
* Version : v_0.1 - created 
* 
*/ 
public without sharing class BatchClassToCreateTaskOnActiveContacts implements database.Batchable<sobject>, Database.Stateful
{
    public String query;
    
    public BatchClassToCreateTaskOnActiveContacts(String str)
    {
        query = str;
    }
    
    public Database.QueryLocator Start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> contactList)
    {
        try
        {
            System.debug('contactList : ' + contactList.size() +' ' + contactList);
            if(contactList.size()>0)
                System.debug('contactList : ' + contactList.size() +' ' + contactList);
            {
                List<Contact> listOfContactToBeUpdated = new List<Contact>();
                List<Task> listOfTaskToBeAssigned = new List<Task>();
                for(Contact con : contactList)
                {
                    if(con.Contact_Type__c == 'Active' && con.Task_Created__c == false)
                    {
                        Task newTask = new task();
                        newTask.WhoId = con.Id;
                        newTask.Subject = 'New Task Is Assigned';
                        newtask.Priority = 'High';
                        newTask.Status = 'InProgress';
                        newTask.OwnerId = '0052w00000CBaTVAA1';
                        listOfTaskToBeAssigned.add(newTask);
                        
                        con.Task_Created__c = true;
                        listOfContactToBeUpdated.add(con);
                        
                    }
                    System.debug('listOfTaskToBeAssigned: '+ listOfTaskToBeAssigned);
                }
                if(listOfTaskToBeAssigned.size()>0)
                {
                    Utilities.BypassAllTriggers = true;
                    insert listOfTaskToBeAssigned;
                    Utilities.BypassAllTriggers = false;
                }
                if(listOfContactToBeUpdated.size()>0)
                {
                    Utilities.BypassAllTriggers = true;
                    update listOfContactToBeUpdated;
                    Utilities.BypassAllTriggers = false;
                }
            }
        }
        Catch(Exception e)
        {
            System.debug('Error While Processing Batch Job' + e.getCause() + ' : ' + e.getMessage());
        }
    }
    
    public void finish(Database.BatchableContext bc)
    {
        
    }
}

/*
BatchClassToCreateTaskOnActiveContacts bc = new BatchClassToCreateTaskOnActiveContacts('SELECT Id, Contact_Type__c, Task_Created__c FROM Contact WHERE Contact_Type__c = \'Active\' AND Task_Created__c == false');
Database.executeBatch(bc, 2);
*/
/*
* Purpose : Batch Class To Update Orphan Students Record.
* 
* Created By : Amit Kumar
* 
* Created Date : 04/10/2023
* 
* Version : v_0.1 - created 
* 
*/ 
public without sharing class BatchClassToUpdateOrphanStudents implements database.batchable<sObject>,Database.Stateful
{
    public String log;
    public String query;
    
    public BatchClassToUpdateOrphanStudents(String str)
    {
        query = str;
    }
    
    public Database.QueryLocator Start(Database.BatchableContext bc)
    {
        return Database.getQueryLocator(query);
    }
    
    public void execute (Database.BatchableContext bc, List<Student__c> listOfOrphanStudents)
    {
        List<Student__c> listOfStudentsToBeUploaded = new List<Student__c>();
        Integer i =1;
        for(Student__c stu : listOfOrphanStudents)
        {
            stu.Test_T_D__c = 'Test'+ i;
            i++;
            listOfStudentsToBeUploaded.add(stu);
        }
        Database.SaveResult[] srList = Database.update(listOfStudentsToBeUploaded,false);
        for(Database.SaveResult sr : srlist)
        {
            if(!sr.isSuccess())
            {
                for(Database.Error err : sr.getErrors())
                {
                    log = err.getStatusCode()+ ':' + err.getMessage();
                }
            }
        }
    }
    
    public void finish(Database.BatchableContext bc)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] {'kumar01072000amit@gmail.com'});
        mail.setReplyTo('amit.kumar@fexle.com');
        mail.setSenderDisplayName('BatchClassToUpdateOrphanStudents - Batch Processing');
        mail.setSubject('BatchClassToUpdateOrphanStudents - Batch Process Completed');
        mail.setPlainTextBody('BatchClassToUpdateOrphanStudents - Batch Process has completed ' + log + ' ' + query);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}

/*
BatchClassToUpdateOrphanStudents bc = new BatchClassToUpdateOrphanStudents('SELECT Name, Id, Student__r.Class__c, Test_T_D__c FROM Student__c WHERE Student__r.Class__c == null');
Database.executeBatch(bc, 2);
*/
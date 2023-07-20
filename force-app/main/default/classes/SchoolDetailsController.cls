/*
* 
* Purpose : Apex Class To Have Business Logics Related To "SchoolDetails" LWC Component.
* 
* Created By : Amit Kumar
* 
* Created Date : 05/20/2023
* 
* Version : v_0.1 - created 
* 
*/
public with sharing class SchoolDetailsController 
{
    @auraEnabled(cacheable=false)
    public static ResponseWrapper doQuery(String recordId)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            if(String.isNotBlank(recordId))
            {
                List<Class__c> listOfClass = [SELECT Id, Name, Board__c, Student__c, CreatedById, CreatedDate, 
                                              (SELECT ID, Name, Type__c, Father_NAme__c, Father_Email__c FROM Students__r) 
                                              FROM Class__C 
                                              WHERE School__c =: recordId];
                if(listOfClass.size()>0)
                {
                    rw.setBody(listOfClass);
                }
                else
                {
                    rw.setError('No Class Was Related To School');
                }
            }
            else
            {
                //Please Enter Record Id
                rw.setError('Please Enter Record Id');
            }
        }
        catch(Exception ex)
        {
            rw.setError(ex.getCause() + ' : ' + ex.getMessage());
        }
        return rw;
    }
    
    @auraEnabled(cacheable=false)
    public static ResponseWrapper deleteRecord(String studentId)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            if(String.isNotBlank(studentId))
            {
                List<Student__c> listOfStudentToBeDeleted = [SELECT Id FROM Student__c WHERE Id =: studentId];
                if(listOfStudentToBeDeleted.size()>0)
                {
                    Database.delete(listOfStudentToBeDeleted);
                    System.debug('Student Record Deleted Sucessfully');
                }
                else
                {
                    system.debug('listOfStudentToBeDeleted is Empty');
                    rw.setError('Student You Wants To Delete Is Not Present In Student Record');
                }
            }
            else
            {
                system.debug('Student Record Id Is Missing');
                rw.setError('Student Record Id Is Missing');
            }
        }
        catch(exception ex)
        {
            system.debug(ex.getCause() + ' : ' + ex.getMessage());
            rw.setError(ex.getCause() + ' : ' + ex.getMessage());
        }
        return rw;
    }
    
    @auraEnabled(cacheable=false)
    public static ResponseWrapper deleteBulk(List<Id> studentIdList)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            if(studentIdList.size()>0)
            {
                List<Student__c> listOfStudentToBeDeleted = [SELECT Id FROM Student__c WHERE Id IN: studentIdList];
                if(listOfStudentToBeDeleted.size()>0)
                {
                    Delete listOfStudentToBeDeleted;
                    System.debug('All Records Are Deleted SuccessFully');
                    rw.setMessage('All Records Are Deleted SuccessFully');
                    
                }
                else
                {
                    System.debug('Selected Student Records Not Found In Database');
                    rw.setError('Selected Student Records Not Found In Database');
                }
            }
            else
            {
                System.debug('Please Select Atleast One Student');
                rw.setError('Please Select Atleast One Student');
            }
        }
        catch(Exception ex)
        {
            system.debug(ex.getCause() + ' : ' + ex.getMessage());
            rw.setError(ex.getCause() + ' : ' + ex.getMessage());
        }
        return rw;
    }
    
    @auraEnabled(cacheable=false)
    public static ResponseWrapper updateBulk(List<Id> studentIdList, String name, String Type, String fatherName, String fatherEmail)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            if(studentIdList.size()>0)
            {
                if(string.isBlank(name) && string.isBlank(Type) && string.isBlank(fatherName) && string.isBlank(fatherEmail))
                {
                    System.debug('Please Update Atleast One Field');
                    rw.setError('Please Update Atleast One Field');
                }
                else
                {
                    List<Student__c> listOfStudentToBeUpdate = [SELECT Id, Name, Type__c, Father_Name__c, Father_Email__c FROM Student__c WHERE Id IN: studentIdList];
                    for(Student__c std : listOfStudentToBeUpdate)
                    {
                        if(String.isNotBlank(name))
                        {
                            std.name = name;
                        }
                        
                        if(String.isNotBlank(type))
                        {
                            std.Type__c = type; 
                        }
                        
                        if(String.isNotBlank(fatherName))
                        {
                            std.Father_Name__c = fatherName;   
                        }
                        
                        if(String.isNotBlank(fatherEmail))
                        {
                            std.Father_Email__c = fatherEmail;
                        }
                        
                    }
                    if(listOfStudentToBeUpdate.size()>0)
                    {
                        update listOfStudentToBeUpdate;
                        System.debug('All Records Are Updated SuccessFully');
                        rw.setMessage('All Records Are Updated SuccessFully');
                    }
                    else
                    {
                        System.debug('Selected Student Records Not Found In Database');
                        rw.setError('Selected Student Records Not Found In Database');
                    }
                }
            }
            else
            {
                system.debug('Please Select Atleast One Student');
                rw.setError('Please Select Atleast One Student');
            }
        }
        catch(Exception ex)
        {
            system.debug(ex.getCause() + ' : ' + ex.getMessage());
            rw.setError(ex.getCause() + ' : ' + ex.getMessage());
        }
        return rw;
    }
}
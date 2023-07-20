/*
* 
* Purpose : Apex Class To Have Business Logics Related To "ObjectRecordDetails" LWC Component.
* 
* Created By : Amit Kumar
* 
* Created Date : 05/22/2023
* 
* Version : v_0.1 - created 
* 
*/
public with sharing class ObjectRecordDetailsController 
{
    @AuraEnabled(cacheable=false)
    public static List<sObject> getRecordDetail(String recordId, String objectName)
    {
        try
        {
            if(String.isNotBlank(recordId))
            {
                if(String.isNotBlank(objectName))
                {
                    List<sObject> recordDetails = Database.query('SELECT Id, Name, CreatedById, CreatedDate FROM '+objectName+' WHERE Id =:'+recordId+'');
                    if(recordDetails.size()>0)
                    {
                        system.debug('@@@ recordDetails : ' + recordDetails);
                        return recordDetails;
                    }
                    else
                    {
                        System.Debug('recordDetails IS Empty');
                        return null;
                    }
                }
                else
                {
                    System.debug('Object Name Is Null');
                    return null;
                }
            }
            else
            {
                System.debug('Record Id Is Null');
                return null;
            }
        }
        catch(Exception ex)
        {
            return null;
        }
    }
}
/*
* 
* Purpose : Apex Class To Have Business Logics Related To "ObjectRecordsSelector" LWC Component.
* 
* Created By : Amit Kumar
* 
* Created Date : 05/22/2023
* 
* Version : v_0.1 - created 
* 
*/
public with sharing class ObjectRecordsSelectorController 
{
    @AuraEnabled(cacheable=false)
    public static List<sObject> getRecords(String objectName)
    {
        Try
        {
            if(String.isNotBlank(objectName))
            {
                List<sObject> listOfRecords = Database.query('SELECT ID, Name FROM '+objectName+'');
                if(listOfRecords.size()>0)
                {
                    return listOfRecords;
                }
                else
                {
                    System.debug('listOfRecords is Empty');
                    return null;
                }
            }
            else
            {
                System.debug('Object Name Is Null');
                return null;
            }
        }
        catch(Exception ex)
        {
            system.debug(ex.getCause() + ' : ' + ex.getMessage());
            return null;
        }
    }
}
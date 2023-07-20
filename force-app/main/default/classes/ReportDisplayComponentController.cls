/*
* 
* Purpose : Apex Class To Have Business Logics Related To "ReportDisplayComponent" LWC Component.
* 
* Created By : Amit Kumar
* 
* Created Date : 05/27/2023
* 
* Version : v_0.1 - created 
* 
*/
public with sharing class ReportDisplayComponentController 
{
    @auraEnabled(cacheable=false)
    public static ResponseWrapper getObject()
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            List<String> listOfObject = new List<String>(); 
            for(EntityDefinition ed : [SELECT DeveloperName, QualifiedApiName FROM EntityDefinition 
                                       WHERE IsCustomizable = true 
                                       AND IsRetrieveable = true 
                                       AND IsCustomSetting = false ORDER BY DeveloperName ASC])
            {
                listOfObject.add(ed.QualifiedApiName);
            }
            if(listOfObject.size()>0)
            {
                rw.setList(listOfObject);
                System.debug('mapOfObject : ' + listOfObject);
            }
            else
            {
                System.debug('No Object Found');
                rw.setError('No Object Found');
            }
        }
        catch(Exception ex)
        {
            rw.setError(ex.getCause() + ' : ' + ex.getMessage());
            system.debug(ex.getCause() + ' : ' + ex.getMessage());
        }
        return rw;
    }
    
    @auraEnabled(cacheable=false)
    public static ResponseWrapper getField(String selectedObjectname)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            if(String.isNotBlank(selectedObjectname) && Utilities.getObjectIsAccessible(selectedObjectname))
            {
                //Getting Selected Object Fields on Map
                Map<String, Schema.SObjectField> mapOfAllFiledsOfSelectedObject = Utilities.getFieldsMap(selectedObjectname);
                List<String> listOfFields = new List<String>();
                for(String fieldnames : mapOfAllFiledsOfSelectedObject.keySet())
                {
                    listOfFields.add(fieldnames);
                }
                if(listOfFields.size()>0)
                {
                    rw.setList(listOfFields);
                    System.debug('listOfFields : ' + listOfFields);
                }
                else
                {
                    System.debug('No Fields Found');
                    rw.setError('No Fields Found');
                }
            }
            else
            {
                rw.setError('Selected Object Is null OR Is Not Accessible');
                System.debug('Selected Object Is null OR Is Not Accessible');
            }
        }
        catch(Exception ex)
        {
            rw.setError(ex.getCause() + ' : ' + ex.getMessage());
            system.debug(ex.getCause() + ' : ' + ex.getMessage());
        }
        return rw;
    }
    
    @auraEnabled(cacheable=false)
    public static ResponseWrapper getRecord()
    {
        ResponseWrapper rw = new ResponseWrapper();
        List<Contact> listOfContact = [SELECT ID, LastName, CreatedDate FROM Contact];
        rw.setRecordList(listOfContact);
        System.debug('listOfContact : ' + listOfContact);
        System.debug('rw recordList : ' + rw.recordList);
        return rw;
    }
}
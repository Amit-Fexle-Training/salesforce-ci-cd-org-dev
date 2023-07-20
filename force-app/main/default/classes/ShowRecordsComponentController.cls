/**
*
*  Purpose          :   Apex class to have business logics related to "ShowRecordsComponent" LWC component.
*
*  Created Date     :   06/01/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public with sharing class ShowRecordsComponentController 
{
    @auraEnabled(cacheable=false)
    public static ResponseWrapper getRecords(String objectName)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            if(String.isNotBlank(objectName))
            {
                String queryString = 'SELECT Id, Name FROM ' + objectName + ' ORDER BY CreatedDate DESC';
                List<sObject> listOfRecords = Database.query(queryString);
                rw.setRecordList(listOfRecords);
                System.debug('listOfRecords : ' + listOfRecords);
            }
            else
            {
                System.debug('objectName Is Null');
                rw.setError('objectName Is Null');
            }
        }
        catch(Exception ex)
        {
            rw.setError(ex.getCause() + ' : ' + ex.getMessage());
            system.debug(ex.getCause() + ' : ' + ex.getMessage());
        }
        return rw;
    }
}
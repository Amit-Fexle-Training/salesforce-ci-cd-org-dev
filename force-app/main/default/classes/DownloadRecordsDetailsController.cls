/*
* 
* Purpose : Apex Class To Have Business Logics Related To "DownloadRecordsDetails" LWC Component.
* 
* Created By : Amit Kumar
* 
* Created Date : 06/03/2023
* 
* Version : v_0.1 - created 
* 
*/
public with sharing class DownloadRecordsDetailsController 
{
    @auraEnabled(cacheable=false)
    public static ResponseWrapper getRecord(String accountId)
    {
        ResponseWrapper rw = new ResponseWrapper();
        try
        {
            if(String.isNotBlank(accountId))
            {
                List<Contact> listOfRelatedContact = [SELECT FirstName, LastName, Phone, Email FROM Contact WHERE AccountId =: accountId]; 
                if(listOfRelatedContact.size()>0)
                {
                    rw.setBody(listOfRelatedContact);
                }
                else
                {
                    rw.setError('No Contact Was Related To Account');
                }
            }
            else
            {
                System.debug('No RecordId Found');
                rw.setError('No RecordId Found');
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
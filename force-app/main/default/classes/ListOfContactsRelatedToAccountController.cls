/*
* 
* Purpose : Apex Class To Have Business Logics Related To "listOfContactsRelatedToAccount" LWC Component.
* 
* Created By : Amit Kumar
* 
* Created Date : 05/20/2023
* 
* Version : v_0.1 - created 
* 
*/
public with Sharing class ListOfContactsRelatedToAccountController 
{
    @auraEnabled(cacheable=false)
    public static List<sObject> doQuery(String recordId)
    {
        try
        {
            if(String.isNotBlank(recordId))
            {
                List<Contact> listOfContact = [SELECT Id, LastName, FirstName FROM Contact WHERE AccountId =: recordId];
                if(listOfContact.size()>0)
                {
                    return listOfContact;
                }
                else
                {
                    return null;
                }
            }
            else
            {
                //Please Enter Record Id
                return null;
            }
        }
        catch(Exception ex)
        {
            return null;
        }
    }
}
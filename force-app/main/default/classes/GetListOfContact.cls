/*
* Purpose : Class With Invocable Method That Will Return A List Of Contact.
* 
* Created By : Amit Kumar
* 
* Created Date : 05/11/2023
* 
* Version : v_0.1 - created 
* 
*/
public with sharing Class GetListOfContact 
{
    @InvocableMethod(label='Get List Of Contact' description='Invocable Method That Will Return A List Of Contact')
    public static List<List<String>> getListOfContacts(List<Account> accountRecord)
    {
        if(String.isNotBlank(accountRecord[0].Contact_List__c))
        {
            List<List<String>> listOfContact = new List<List<String>>();
            
            List<String> contactDetails = accountRecord[0].Contact_List__c.split('\\n');
            System.debug('contactDetails : ' + contactDetails);
            listOfContact.add(contactDetails);
            return listOfContact;
        }
        return null;
    }
}
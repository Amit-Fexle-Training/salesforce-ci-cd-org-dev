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
public with sharing class ListOfContact 
{
    @InvocableMethod(label='List Of Contact' description='Invocable Method That Will Return A List Of Contact')
    public static List<List<Contact>> listOfContactToReturn(List<Account> accountRecord)
    {
        List<List<Contact>> listOfContact = new List<List<Contact>>();
        
        if(accountRecord.size()>0)
        {
            for(Account acc : accountRecord)
            {
                List<Contact> tempContactList = new List<Contact>();
                if(String.isNotBlank(acc.Contact_List__c))
                {  
                    List<String> contactDetails = acc.Contact_List__c.split('\\n');
                    if(contactDetails.size()>0)
                    {
                        for(String conDetails : contactDetails)
                        {
                            List<String> newContactDetails = conDetails.split(',');
                            System.debug('newContactDetails : ' + newContactDetails);
                            if(newContactDetails.size()==3)
                            {
                                Contact con = new Contact();
                                con.AccountId = acc.Id;
                                
                                for(String fieldDetails : newContactDetails)
                                {
                                    List<String> fieldNameAndValues = fieldDetails.split(':');
                                    System.debug('fieldNameAndValues : ' + fieldNameAndValues);
                                    
                                    con.put(fieldNameAndValues[0], fieldNameAndValues[1]);
                                    
                                }
                                tempContactList.add(con);
                            }  
                        }
                    }
                }
               listOfContact.add(tempContactList); 
            }
            System.debug('listOfContact : ' + listOfContact);
            
        }
        return listOfContact;
    }
}
/*
* 
* Purpose : Apex Class To Have Business Logics Related To "InsertMultipleContactComponent" LWC Component.
* 
* Created By : Amit Kumar
* 
* Created Date : 05/30/2023
* 
* Version : v_0.1 - created 
* 
*/
public with sharing class InsertMultipleContactComponentController 
{
    @auraEnabled(cacheable=false)
    public static ResponseWrapper addRecord(List<Contact> contactList)
    {
        ResponseWrapper rw = new ResponseWrapper();
        System.debug('contactList : ' + contactList);
        try
        {
            if(contactList.size()>0)
            {
                List<Contact> listOfContactToBeInserted = new List<Contact>();
                for(Contact con : contactList)
                {
                    Contact contact= new Contact();
                    contact.LastName = con.LastName;
                    contact.FirstName = con.FirstName;
                    contact.Email = con.Email;
                    
                    listOfContactToBeInserted.add(contact);
                }
                
                if(listOfContactToBeInserted.size()>0)
                {
                    System.debug('listOfContactToBeInserted : ' + listOfContactToBeInserted);
                    Database.insert(listOfContactToBeInserted, true);
                    rw.setMessage('Contacts Inserted Successfully');
                }
                else
                {
                    System.debug('listOfContactToBeInserted Is Empty');
                	rw.setError('Contact List Is Empty');
                }
            }
            else
            {
                System.debug('Contact List Is Empty');
                rw.setError('Contact List Is Empty');
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
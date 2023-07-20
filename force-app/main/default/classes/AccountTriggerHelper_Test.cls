/**
*
*  Purpose          :	Test Class for AccountTriggerHelper class.
*
*  Created Date     :  	11/18/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
@isTest(seeAllData=false)
public without sharing class AccountTriggerHelper_Test 
{
    @testSetup
    public static void setup()
    {
        List<Account> listOfAccountsToBeAdded = new List<Account>();
        for(Integer i=1; i<=2; i++)
        {
            Account acc = new Account(Name = 'Test Account ' + i);
            listOfAccountsToBeAdded.add(acc);
        }
        
        if(listOfAccountsToBeAdded.size()>0)
        {
            insert listOfAccountsToBeAdded;
        }
        
        List<Contact> listOfContactsToBeAdded = new List<Contact>();
        for(Integer i=1; i<=3; i++)
        {
            Contact con = new Contact(LastName = 'Test Contact ' + i, AccountId = listOfAccountsToBeAdded[0].Id);
            listOfContactsToBeAdded.add(con);
        }
        
        for(Integer i=4; i<=5; i++)
        {
            Contact con = new Contact(LastName = 'Test Contact ' + i, AccountId = listOfAccountsToBeAdded[1].Id);
            listOfContactsToBeAdded.add(con);
        }
        
        if(listOfContactsToBeAdded.size()>0)
        {
            insert listOfContactsToBeAdded;
        }
    }
    
    @isTest(seeAllData=false)
    public static void testDeleteAssociatedContacts()
    {
        List<Account> listOfAccounts = [SELECT Id FROM Account];
        System.assertEquals(2, listOfAccounts.size());
        
        Test.startTest();
        delete listOfAccounts;
        
        List<Contact> listOfContacts = [SELECT Id FROM Contact WHERE AccountId != null];
        System.assertEquals(0, listOfContacts.size());
        Test.stopTest();
    }
}
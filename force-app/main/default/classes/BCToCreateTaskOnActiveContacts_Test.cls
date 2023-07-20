/*
* Purpose : Test Class For BatchClassToCreateTaskOnActiveContacts
* 
* Created By : Amit Kumar
* 
* Created Date : 04/24/2023
* 
* Version : v_0.1 - created 
* 
*/ 
@isTest(seeAllData=false)
public without sharing class BCToCreateTaskOnActiveContacts_Test 
{
    @testSetup
    public static void setup()
    {
        List<Contact> contacts = (List<Contact>)SmartFactory.createSObjectList('Contact', false, 150);
        integer i = 1;
        for(Contact con : contacts)
        {
            if(i<= 100)
            {
                con.Contact_Type__c = 'Active';
                i++;
            }
            else
            {
                con.Contact_Type__c = 'InActive';
            }
            
        }
        Utilities.BypassAllTriggers = true;
        insert contacts;
        Utilities.BypassAllTriggers = false;
        System.assertEquals(150, contacts.size());
    }
    
    @isTest(seeAllData=false)
    private static void testBCToCreateTaskOnActiveContacts()
    {
        List<Contact> listOfContacts = [SELECT Id, Contact_Type__c, Task_Created__c FROM Contact];
        
        Test.startTest();
        BatchClassToCreateTaskOnActiveContacts bc = new BatchClassToCreateTaskOnActiveContacts('SELECT Id, Contact_Type__c, Task_Created__c FROM Contact WHERE Contact_Type__c = \'Active\'');
        Database.executeBatch(bc, 200);
        
        Test.stopTest();
        
        List<Contact> listOfContactsForValidation1 = [SELECT Id, Contact_Type__c, Task_Created__c FROM Contact WHERE Contact_Type__c = 'Active' AND Task_Created__c = true];
        System.assertEquals(100, listOfContactsForValidation1.size());
        
        List<Contact> listOfContactsForValidation2 = [SELECT Id, Contact_Type__c, Task_Created__c FROM Contact WHERE Contact_Type__c = 'InActive' AND Task_Created__c = false];
        System.assertEquals(50, listOfContactsForValidation2.size());
    }
}
/**
*
*  Purpose          :	Helper Class for Trigger on Account object.
*
*  Created Date     :  	04/11/2022
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class AccountTriggerHelper 
{
    public static void deleteChildContactsOnParentAccountDelete(Map<Id, Account> mapOfOldAccounts) 
    {
        if(mapOfOldAccounts != null && mapOfOldAccounts.values().size() > 0) 
        {
            AccountTriggerHelper.deleteAssociatedContacts(mapOfOldAccounts);
        }       
    }
    
    /*
    public static void deleteChildContactsOnParentAccountDeleteOnAfter(Map<Id, Account> mapOfOldAccounts) 
    {
        if(mapOfOldAccounts != null && mapOfOldAccounts.values().size() > 0) 
        {
            AccountTriggerHelper.deleteAssociatedContacts(mapOfOldAccounts);
        }
    }
    */    

    private static void deleteAssociatedContacts(Map<Id, Account> mapOfOldAccounts)
    {
      if(mapOfOldAccounts != null && mapOfOldAccounts.values().size() > 0)
      {
          List<Contact> listOfContactsToBeDeleted = [SELECT ID, AccountId 
                                                           FROM Contact
                                                           WHERE AccountId IN : mapOfOldAccounts.keySet()
                                                          ];
          if(listOfContactsToBeDeleted.size() > 0) 
          {
              Utilities.BypassAllTriggers = true;
              delete listOfContactsToBeDeleted;
              Utilities.BypassAllTriggers = false;
          }
      }
    }
    
    public static void createRelatedContacts(List<Account> accList)
    {
        List<Contact> listOfContacts = new List<Contact>();
        if(accList!=null || accList.size()>0){
            for(Account acc : accList)
            {
                
                if(acc.Contact_Name__c != null)
                {
                    List<String> contactLastName = acc.Contact_Name__c.split(',');
                    
                    for(String conLastName : contactLastName)
                    {
                        Contact con = new Contact();
                        con.AccountId = acc.Id;
                        con.LastName = conLastName;
                        con.Email = conLastName+'@testgmail.com';
                        
                        listOfContacts.add(con);
                    }
                }
            }
        }
        if(listOfContacts.size()>0){
            insert listOfContacts;
        }
   
    }
    
    public static void addAndDeleteRelatedContacts(List<Account> accList, Map<Id, Account> accOldMap)
    {
        if(accOldMap.values()!= null && accOldMap.values().size()>0)
        {
            for(Account acc : accList)
            {
                if(accOldMap.get(acc.Id).Contact_Name__c != null)
                {
                    if(acc.Contact_Name__c != null)
                {
                    if(acc.Contact_Name__c != accOldMap.get(acc.Id).Contact_Name__c)
                    {
                        List<String> newContactLastName = acc.Contact_Name__c.split(',');
                        List<String> oldContactLastName = accOldMap.get(acc.Id).Contact_Name__c.split(',');
                        
                        List<String> contactToBeDeleted = new List<String>();
                        List<String> contactToBeInserted = new List<String>();
                        
                        for(Integer i=0; i<oldContactLastName.size(); i++)
                        {
                            for(Integer j=0; j<newContactLastName.size(); j++)
                            {
                                Integer flag = 0;
                                if(oldContactLastName[i] != newContactLastName[j] )
                                {
                                    contactToBeDeleted.add(oldContactLastName[i]);
                                    flag = 1;
                                }
                                if(flag == 1)
                                {
                                    break;
                                }
                            }
                        }
                        
                        for(Integer i=0; i<newContactLastName.size(); i++)
                        {
                            for(Integer j=0; j<oldContactLastName.size(); j++)
                            {
                                Integer flag = 0;
                                if(newContactLastName[i] != oldContactLastName[j] )
                                {
                                    contactToBeInserted.add(newContactLastName[i]);
                                    flag = 1;
                                }
                                if(flag == 1)
                                {
                                    break;
                                }
                            }
                        }
                        
                        List<Contact> conToBeDeleted = [SELECT Id From Contact Where Name IN : contactToBeDeleted];
                        List<Contact> conToBeInserted = new List<Contact>();
                        for(String conLastName : contactToBeInserted)
                        {
                            Contact con = new Contact();
                            con.AccountId = acc.Id;
                            con.LastName = conLastName;
                            con.Email = conLastName+'@testgmail.com';
                            
                            conToBeInserted.add(con);
                        }
                        
                        if(conToBeDeleted.size()> 0)
                        {
                            utilities.BypassAllTriggers=true;
                            delete conToBeDeleted;
                            utilities.BypassAllTriggers=false;
                        }
                        
                        if(conToBeInserted.size()> 0)
                        {
                            utilities.BypassAllTriggers=true;
                            insert conToBeInserted;
                            utilities.BypassAllTriggers=false;
                        }
                    }
                }
                   else
                   {
                       List<String> oldContactLastName = accOldMap.get(acc.Id).Contact_Name__c.split(',');
                       List<Contact> conToBeDeleted = [SELECT Id From Contact Where Name IN : oldContactLastName];
                       if(conToBeDeleted.size()> 0)
                        {
                            utilities.BypassAllTriggers=true;
                            delete conToBeDeleted;
                            utilities.BypassAllTriggers=false;
                        }
                       
                   }
                }
                else
                {
                    List<String> newContactLastName = acc.Contact_Name__c.split(',');
                    List<Contact> conToBeInserted = new List<Contact>();
                    for(String conLastName : newContactLastName)
                        {
                            Contact con = new Contact();
                            con.AccountId = acc.Id;
                            con.LastName = conLastName;
                            con.Email = conLastName+'@testgmail.com';
                            
                            conToBeInserted.add(con);
                        }
                    if(conToBeInserted.size()> 0)
                        {
                            utilities.BypassAllTriggers=true;
                            insert conToBeInserted;
                            utilities.BypassAllTriggers=false;
                        }
                    
                }
                
            }
        }
    }
}
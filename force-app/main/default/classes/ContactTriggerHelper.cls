/**
*
*  Purpose          :	Helper Class for Trigger on Contact object.
*
*  Created Date     :  	04/17/2022
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class ContactTriggerHelper 
{
    public static void removeDeletedContactNameFromAccountContactNameField(Map<Id, Contact> mapOfOldContact)
    {
        if(mapOfOldContact.values()!=null && mapOfOldContact.values().size()>0)
        {
            
            Set<Id> setOfDeletedContactRelatedAccountId = new Set<Id>();
            for(Contact con : mapOfOldContact.values())
            {
                if(con.AccountId!=null)
                {
                    setOfDeletedContactRelatedAccountId.add(con.AccountId);
                }
            }
            System.debug('@@@setOfDeletedContactRelatedAccountId: '+setOfDeletedContactRelatedAccountId);
            List<Account> listOfAccountToBeUpdated = new List<Account>();
            for(Account acc : [SELECT Id, Contact_Name__c FROM Account WHERE Id IN : setOfDeletedContactRelatedAccountId])
            {
                String updatedFieldValue='';
                for(Contact con : [SELECT LastName FROM Contact WHERE AccountId =: acc.Id])
                {
                    updatedFieldValue += con.LastName +',';
                }
                
                acc.Contact_Name__c = updatedFieldValue.removeEnd(',');
                
                listOfAccountToBeUpdated.add(acc);
                System.debug('@@@updatedFieldValue: '+updatedFieldValue);
            }
            
            
            
            if(listOfAccountToBeUpdated.size()>0)
            {
                utilities.BypassAllTriggers=true;
                update listOfAccountToBeUpdated;
                utilities.BypassAllTriggers=false;
            }
            
            System.debug('@@@listOfAccountToBeUpdated: '+listOfAccountToBeUpdated);
        }
    }
    
    public static void addContactsToRelatedAccount(List<Contact> contactList)
    {
        if(contactList.size()>0)
        {
            Set<Id> setOfAccountIdsRelatedToNewContact = new Set<Id>();
            for(Contact con : contactList)
            {
                if(con.AccountId!=null)
                {
                    setOfAccountIdsRelatedToNewContact.add(con.AccountId);
                }
            }
            System.debug('@@@setOfAccountIdsRelatedToNewContact: '+setOfAccountIdsRelatedToNewContact);
            
            List<Account> listOfAccountToBeUpdated = new List<Account>();
            for(Account acc : [SELECT Id, Contact_Name__c FROM Account WHERE Id IN : setOfAccountIdsRelatedToNewContact])
            {
                String updatedFieldValue = '';
                System.debug('@@@updatedFieldValue: '+updatedFieldValue);
                for(Contact con : [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId =: acc.Id])
                {
                    updatedFieldValue += con.LastName+',';
                }
                acc.Contact_Name__c = updatedFieldValue.removeEnd(',');
                System.debug('@@@updatedFieldValue: '+updatedFieldValue);
                listOfAccountToBeUpdated.add(acc);
            }
            
            if(listOfAccountToBeUpdated.size()>0)
            {
                utilities.BypassAllTriggers=true;
                update listOfAccountToBeUpdated;
                utilities.BypassAllTriggers=false;
            }
            System.debug('listOfAccountToBeUpdated'+listOfAccountToBeUpdated);
        }
    }
    
    public static void updateAccountAfterUpdateInRelatedContactLastName(List<Contact> contactList, Map<Id, Contact> mapOfOldContact)
    {
        if(contactList.size()>0)
        {
             Set<Id> setOfAccountIdsRelatedToNewContact = new Set<Id>();
            for(Contact con : contactList)
            {
                if(con.AccountId!=null && (con.LastName != mapOfOldContact.get(con.Id).LastName))
                {
                    setOfAccountIdsRelatedToNewContact.add(con.AccountId);
                }
            }
            
            if(setOfAccountIdsRelatedToNewContact.size()>0)
            {
                List<Account> listOfAccountToBeUpdated = new List<Account>();
                for(Account acc : [SELECT Id, Contact_Name__c FROM Account WHERE Id IN : setOfAccountIdsRelatedToNewContact])
                {
                    String updatedFieldValue = '';
                    System.debug('@@@updatedFieldValue: '+updatedFieldValue);
                    for(Contact con : [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId =: acc.Id])
                    { 
                       updatedFieldValue += con.LastName+',';
                    }
                    acc.Contact_Name__c = updatedFieldValue.removeEnd(',');
                    System.debug('@@@updatedFieldValue: '+updatedFieldValue);
                    listOfAccountToBeUpdated.add(acc);
                }
                if(listOfAccountToBeUpdated.size()>0)
                {
                   utilities.BypassAllTriggers=true;
                   update listOfAccountToBeUpdated;
                   utilities.BypassAllTriggers=false;
                }
                System.debug('listOfAccountToBeUpdated'+listOfAccountToBeUpdated);
            }
        }
    }
    
    public static void updateRelatedAccountAfterReparentingOfRelatedContact(List<Contact> contactList, Map<Id, Contact> mapOfOldContact)
        {
           if(contactList.size()>0)
           {
               Set<Id> setOfOldRelatedAccountId = new Set<Id>();
               Set<Id> setOfNewRelatedAccountId = new Set<Id>();
               for(Contact con : contactList)
               {
                   if(con.AccountId!=null && (con.AccountId != mapOfOldContact.get(con.Id).AccountId))
                   {
                       setOfOldRelatedAccountId.add(con.AccountId);
                       setOfNewRelatedAccountId.add(mapOfOldContact.get(con.Id).AccountId);
                   }
               }
               
               if(setOfOldRelatedAccountId.size()>0 && setOfNewRelatedAccountId.size()>0)
               {
                   List<Account> listOfAccountToBeUpdated = new List<Account>();
                   for(Account acc : [SELECT Id, Contact_Name__c FROM Account WHERE Id IN : setOfOldRelatedAccountId])
                   {
                		String updatedFieldValue='';
                		for(Contact con : [SELECT LastName FROM Contact WHERE AccountId =: acc.Id])
                		{
                 		   updatedFieldValue += con.LastName +',';
                		}
                
                	acc.Contact_Name__c = updatedFieldValue.removeEnd(',');
                
                	listOfAccountToBeUpdated.add(acc);
                	System.debug('@@@updatedFieldValue: '+updatedFieldValue);
            		}
                   
                   for(Account acc : [SELECT Id, Contact_Name__c FROM Account WHERE Id IN : setOfNewRelatedAccountId])
            		{
                		String updatedFieldValue = '';
                		System.debug('@@@updatedFieldValue: '+updatedFieldValue);
                		for(Contact con : [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId =: acc.Id])
                	{
                  		  updatedFieldValue += con.LastName+',';
                	}
                	acc.Contact_Name__c = updatedFieldValue.removeEnd(',');
                	System.debug('@@@updatedFieldValue: '+updatedFieldValue);
                	listOfAccountToBeUpdated.add(acc);
            		}
            
            		if(listOfAccountToBeUpdated.size()>0)
            		{
               			utilities.BypassAllTriggers=true;
                		update listOfAccountToBeUpdated;
                		utilities.BypassAllTriggers=false;
           			}
               	}
           	}
        }
    
    public static void updateRelatedAccountAfterUndeleteOfRelatedContact(List<Contact> contactList)
    {
        if(contactList.size()>0)
        {
            Set<Id> setOfAccountIdsRelatedToContact = new Set<Id>();
            for(Contact con : contactList)
            {
                if(con.AccountId != null)
                {
                    setOfAccountIdsRelatedToContact.add(con.AccountId);
                }
            }
            system.debug('setOfAccountIdsRelatedToContact: '+setOfAccountIdsRelatedToContact);
            if(setOfAccountIdsRelatedToContact.size()>0)
            {
                List<Account> listOfAccountToBeUpdated = new List<Account>();
                for(Account acc : [SELECT Id, Contact_Name__c FROM Account WHERE Id IN : setOfAccountIdsRelatedToContact])
            		{
                		String updatedFieldValue = '';
                		System.debug('@@@updatedFieldValue: '+updatedFieldValue);
                		for(Contact con : [SELECT Id, LastName, AccountId FROM Contact WHERE AccountId =: acc.Id ])
                	{
                  		  updatedFieldValue += con.LastName+',';
                	}
                	acc.Contact_Name__c = updatedFieldValue.removeEnd(',');
                	System.debug('@@@updatedFieldValue: '+updatedFieldValue);
                	listOfAccountToBeUpdated.add(acc);
            		}
            
            		if(listOfAccountToBeUpdated.size()>0)
            		{
               			utilities.BypassAllTriggers=true;
                        Database.DMLOptions dml = new Database.DMLOptions();
                        dml.DuplicateRuleHeader.AllowSave = true;
                		Database.update(listOfAccountToBeUpdated, dml);
                		utilities.BypassAllTriggers=false;
           			}
            }
        }
    }
    
    /*
Methods for Task On Trigger Where Contact Layout Field On Account Is To Be Updated as Per The Following Senarios :
1)If New Related Account is Added
2)If Related Account  is Deleted
3)If There Is Any Update in Related Contact First Name, Last Name And Email 
4)In Case Of Reparenting
    */
    
    //1)If New Related Account is Added
    public static void addContactDetailToRelatedAccountContactLayoutField(List<Contact> contactList)
    {
        if(contactList.size()>0)
        {
            Set<Id> setOfRelatedAccountId = new Set<Id>();
            for(Contact con : contactList)
            {
                if(con.AccountId!=null)
                {
                    setOfRelatedAccountId.add(con.AccountId);
                }
            }
            if(setOfRelatedAccountId.size()>0)
            {
                List<Account> listOfAccountToBeUpdated = new List<Account>();
                for(Account acc : [SELECT Id, Contact_Layout__c FROM Account WHERE Id IN : setOfRelatedAccountId])
                {
                    for(Contact con : contactList)
                    {
                        if(con.AccountId == acc.Id)
                        {
                            String conLayout;
                            conLayout = con.FirstName+' '+con.LastName+' : '+con.Email;
                            if(acc.Contact_Layout__c == null)
                            {
                                acc.Contact_Layout__c = conLayout;
                            }
                            else
                            {
                                acc.Contact_Layout__c = acc.Contact_Layout__c + '\n' + conLayout;
                            }
                            
                        }
                    }
                    listOfAccountToBeUpdated.add(acc);
                }
                
                if(listOfAccountToBeUpdated.size()>0)
                {
                   utilities.BypassAllTriggers=true;
                   update listOfAccountToBeUpdated;
                   utilities.BypassAllTriggers=false;
                }
            }
        }
    }
    
    //2)If Related Account  is Deleted
    public static void updateContactLayoutFieldOnAccountWhenRelatedContactDeleted(Map<Id, Contact> mapOfOldContact)
    {
        if(mapOfOldContact.values()!=null && mapOfOldContact.values().size()>0)
        {
            Set<Id> setOfRelatedAccountId = new Set<Id>();
            for(Contact con : mapOfOldContact.values())
            {
                if(con.AccountId!=null)
                {
                    setOfRelatedAccountId.add(con.AccountId);
                }
            }
            if(setOfRelatedAccountId.size()>0)
            {
                List<Account> listOfAccountToBeUpdated = new List<Account>();
                for(Account acc : [SELECT Id, Contact_Layout__c FROM Account WHERE Id IN : setOfRelatedAccountId])
                {
                    string updateFieldValue;
                    for(Contact con : [SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId =: acc.Id])
                    {
                        String newValue = con.FirstName+' '+con.LastName+' : '+con.Email;
                        if(updateFieldValue== null)
                        {
                            updateFieldValue = newValue;
                        }
                        else
                        {
                            updateFieldValue += '\n' +newvalue;
                        }
                    }
                    acc.Contact_Layout__c = updateFieldValue;
                    listOfAccountToBeUpdated.add(acc);
                }
                if(listOfAccountToBeUpdated.size()>0)
                {
                   utilities.BypassAllTriggers=true;
                   update listOfAccountToBeUpdated;
                   utilities.BypassAllTriggers=false;
                }
            }
        }
        
    }
    
    //3)If There Is Any Update in Related Contact First Name, Last Name And Email
    public static void updateAccountContactLayoutFieldAfterUpdateOnContact(List<Contact> contactList, map<Id, Contact>mapOfOldContact)
    {
        if(contactList.size()>0)
        {
            Set<Id> setOfAccountIdsRelatedToNewContact = new Set<Id>();
            for(Contact con : contactList)
            {
                if(con.AccountId != null && (con.FirstName != mapOfOldContact.get(con.Id).FirstName || con.LastName != mapOfOldContact.get(con.Id).LastName || con.Email != mapOfOldContact.get(con.Id).Email))
                {
                    setOfAccountIdsRelatedToNewContact.add(con.AccountId);
                }
            }
            
            if(setOfAccountIdsRelatedToNewContact.size()>0)
            {
                List<Account> listOfAccountToBeUpdated = new List<Account>();
                for(Account acc : [SELECT Id, Contact_Layout__c FROM Account WHERE Id IN : setOfAccountIdsRelatedToNewContact])
                {
                    string updateFieldValue;
                    for(Contact con : [SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId =: acc.Id])
                    {
                        String newValue = con.FirstName+' '+con.LastName+' : '+con.Email;
                        if(updateFieldValue== null)
                        {
                            updateFieldValue = newValue;
                        }
                        else
                        {
                            updateFieldValue += '\n' +newvalue;
                        }
                    }
                    acc.Contact_Layout__c = updateFieldValue;
                    listOfAccountToBeUpdated.add(acc);
                }
                if(listOfAccountToBeUpdated.size()>0)
                {
                   utilities.BypassAllTriggers=true;
                   update listOfAccountToBeUpdated;
                   utilities.BypassAllTriggers=false;
                }
            }
        }
    }
    
    //4)In Case Of Reparenting
    public static void updateAccountFieldAfterRelatedContactReparenting(List<Contact> contactList, Map<Id,Contact> mapOfOldContact)
    {
        if(contactList.size()>0)
        {
            Set<Id> setOfIdsOfOldParentAccount = new Set<Id>();
            Set<Id> setOfIdsOfNewParentAccount = new Set<Id>();
            
            for(Contact con : contactList)
            {
                if(con.AccountId!=null && (con.AccountId != mapOfOldContact.get(con.Id).AccountId))
                {
                    setOfIdsOfOldParentAccount.add(mapOfOldContact.get(con.Id).AccountId);
                    setOfIdsOfNewParentAccount.add(con.AccountId);
                }
            }
            if(setOfIdsOfOldParentAccount.size()>0 && setOfIdsOfNewParentAccount.size()>0)
                {
                    List<Account> listOfAccountToBeUpdated = new List<Account>();
                    for(Account acc : [SELECT Id, Contact_Layout__c FROM Account WHERE Id IN : setOfIdsOfOldParentAccount])
                    {
                        string updateFieldValue;
                        for(Contact con : [SELECT Id, FirstName, LastName, Email FROM Contact WHERE AccountId =: acc.Id])
                        {
                            String newValue = con.FirstName+' '+con.LastName+' : '+con.Email;
                            if(updateFieldValue== null)
                            {
                               updateFieldValue = newValue;
                            }
                        else
                           {
                               updateFieldValue += '\n' +newvalue;
                           }
                        }
                    acc.Contact_Layout__c = updateFieldValue;
                    listOfAccountToBeUpdated.add(acc);
                    }
                    
                    for(Account acc : [SELECT Id, Contact_Layout__c FROM Account WHERE Id IN : setOfIdsOfNewParentAccount])
                    {
                        for(Contact con : contactList)
                        {
                           if(con.AccountId == acc.Id)
                           {
                               String conLayout;
                               conLayout = con.FirstName+' '+con.LastName+' : '+con.Email;
                               if(acc.Contact_Layout__c == null)
                               {
                                   acc.Contact_Layout__c = conLayout;
                               }
                               else
                               {
                                   acc.Contact_Layout__c = acc.Contact_Layout__c + '\n' + conLayout;
                               }
                            
                            }
                         }
                        listOfAccountToBeUpdated.add(acc);
                    }
                    
                    if(listOfAccountToBeUpdated.size()>0)
                    {
                        utilities.BypassAllTriggers=true;
                        update listOfAccountToBeUpdated;
                        utilities.BypassAllTriggers=false;
                    }
                }
        }
    }
}
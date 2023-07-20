/**
*
*  Purpose          :   Helper Class For Trigger on Contact object.
*
*  Created Date     :   04/28/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class OnContactTriggerHelper 
{
    public static void updateStatusFieldOnContact(List<Contact> contactList)
    {
        if(contactList.size()>0)
        {
            Set<Id> setOfRelatedAccountId = new Set<Id>();
            for(Contact con : contactList)
            {
                if(con.Status__c == null)
                {
                    if(con.AccountId != null)
                    {
                        setOfRelatedAccountId.add(con.AccountId);
                    }
                }
            }
            
            Map<Id, Account> mapOfReltedAccountIdWithAccountRecord = new Map<Id, Account>([SELECT Id, Status__c, Property__c, Property__r.Status__c 
                                                                                           FROM Account
                                                                                          WHERE Id IN : setOfRelatedAccountId]);
            for(Contact con : contactList)
            {
                if(con.Status__c == null && con.AccountId != null)
                {
                    for(Account acc : mapOfReltedAccountIdWithAccountRecord.Values())
                    {
                        if(acc.Status__c != null)
                        {
                            con.Status__c = acc.Status__c;
                        }
                        else if(acc.Status__c == null && acc.Property__c != null)
                        {
                            if(acc.Property__r.Status__c != null)
                            {
                                con.Status__c = acc.Property__r.Status__c;
                            }
                        }
                    }
                }
            }
        }
    }
}
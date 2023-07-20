/**
*
*  Purpose          :	Helper Class for Trigger on Contact object.
*
*  Created Date     :  	24/24/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class OnContactTHelper 
{
    public static void checkDuplicateWhenNewContactInsert(List<Contact> conList)
    {
        if(conList.size()>0)
        {
            Map<String, Id> mapForduplicteCheckString = new Map<String, Id>();
            for(Contact con : [SELECT LastName, FirstName, Email FROM Contact WHERE LastName != null AND FirstNAme != null AND Email != null])
            {
                mapForduplicteCheckString.put(con.LastName+con.FirstName+con.Email, con.Id);
            }
            
            for(Contact con : conList)
            {
                if(String.isNotBlank(con.LastName) && String.isNotBlank(con.LastName) && String.isNotBlank(con.LastName))
                {
                    String contactDuplicteCheckString = con.LastName+con.FirstName+con.Email;
                    if(mapForduplicteCheckString.containsKey(contactDuplicteCheckString))
                    {
                        con.Duplicate_Found__c = true;
                        con.Duplicate_Contact_Id__c = mapForduplicteCheckString.get(contactDuplicteCheckString);
                        
                    }
                }
            }
        }
    }
    
    public static void checkDuplicateWhenContactIsdUpdate(List<Contact> conList, Map<Id, Contact> mapOFOldContact)
    {
        if(conList.size()>0)
        {
            Map<String, Id> mapForduplicteCheckString = new Map<String, Id>();
            for(Contact con : [SELECT LastName, FirstName, Email FROM Contact WHERE LastName != null AND FirstNAme != null AND Email != null])
            {
                mapForduplicteCheckString.put(con.LastName+con.FirstName+con.Email, con.Id);
            }
            
            for(Contact con : conList)
            {
                if((con.LastName != mapOFOldContact.get(con.Id).LastName || con.FirstName != mapOFOldContact.get(con.Id).FirstName
                  || con.Email != mapOFOldContact.get(con.Id).Email))
                {
                    String contactDuplicteCheckString = con.LastName+con.FirstName+con.Email;
                    if(String.isBlank(con.LastName) || String.isBlank(con.FirstName) || String.isBlank(con.Email))
                    {
                            con.Duplicate_Found__c = false;
                            con.Duplicate_Contact_Id__c = '';
                    }
                    else if(!mapForduplicteCheckString.containsKey(contactDuplicteCheckString))
                    {
                        con.Duplicate_Found__c = false;
                        con.Duplicate_Contact_Id__c = '';
                    }
                }
            }
        }
        
    }
}
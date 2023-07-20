/*
* Purpose : Future Class To Get Account Record That Are Not Related With Any Contact Record.
* 
* Created By : Amit Kumar
* 
* Created Date : 04/27/2023
* 
* Version : v_0.1 - created 
* 
*/
global without sharing class FutureClassToGetAccountRecords implements Schedulable
{
    @Future
    public static void getAccountRecordsNotRelatedWithContacts()
    {
        List<Account> acc = [SELECT Id, Name FROM Account WHERE Id Not In (SELECT AccountId FROM Contact)];
        System.debug(acc);
    }
    
    global void execute(SchedulableContext context)
    {
        FutureClassToGetAccountRecords.getAccountRecordsNotRelatedWithContacts();
    }
}
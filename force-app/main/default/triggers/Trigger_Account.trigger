/**
*
*  Purpose          :   Trigger on Account object.
*
*  Created Date     :   04/11/2022
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
trigger Trigger_Account on Account (before update,after insert, after update, before delete, after delete) 
{
    
    try
    {
        if(Utilities.ByPassAllTriggers)// || Utilities.areTriggersOnThisObjectBypassed('Account'))
            return;
        if(Trigger.isBefore)
        {
            
            
            if(Trigger.isDelete)
            {
                AccountTriggerHelper.deleteChildContactsOnParentAccountDelete(trigger.oldMap);
            }
        }
        if(Trigger.isAfter)
        {
            if(Trigger.isInsert)
            {
                AccountTriggerHelper.createRelatedContacts(Trigger.new);
            }
            
            if(Trigger.isUpdate)
            {
                AccountTriggerHelper.addAndDeleteRelatedContacts(Trigger.new, Trigger.oldMap);
            }
            
            if(Trigger.isDelete)
            {
                //AccountTriggerHelper.deleteChildContactsOnParentAccountDeleteOnAfter(trigger.oldMap);
            }
        }
    }
    catch(Exception e)
    {
        integer i=0;
        if(Trigger.isDelete)
        {
            Trigger.Old[i].addError(e.getMessage());
        }
        else
        {
            Trigger.New[i].addError(e.getMessage());
        }
    }
}
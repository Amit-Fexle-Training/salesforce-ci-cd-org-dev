/**
*
*  Purpose          :   Trigger on Contact object.
*
*  Created Date     :   04/17/2022
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
trigger Trigger_Contact on Contact (after delete, after insert, after update, after undelete) 
{
    try
    {
        if(Utilities.BypassAllTriggers)
        return;
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            ContactTriggerHelper.addContactsToRelatedAccount(Trigger.new);
            ContactTriggerHelper.addContactDetailToRelatedAccountContactLayoutField(Trigger.new);
        }
        if(trigger.isUpdate)
        {
            ContactTriggerHelper.updateAccountAfterUpdateInRelatedContactLastName(Trigger.new, Trigger.oldMap);
            ContactTriggerHelper.updateAccountContactLayoutFieldAfterUpdateOnContact(Trigger.new, Trigger.oldMap);
            ContactTriggerHelper.updateAccountFieldAfterRelatedContactReparenting(Trigger.new, Trigger.oldMap);
            ContactTriggerHelper.updateRelatedAccountAfterReparentingOfRelatedContact(Trigger.new, Trigger.oldMap);
        }
        if(Trigger.isDelete)
        {
            ContactTriggerHelper.removeDeletedContactNameFromAccountContactNameField(Trigger.oldMap);
            ContactTriggerHelper.updateContactLayoutFieldOnAccountWhenRelatedContactDeleted(Trigger.oldMap);
        }
        if(Trigger.isunDelete)
        {
            ContactTriggerHelper.updateRelatedAccountAfterUndeleteOfRelatedContact(Trigger.new);
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
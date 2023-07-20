/**
*
*  Purpose          :	Trigger on Custom Order object.
*
*  Created Date     :  	04/26/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
trigger Trigger_Order on Order__c (before insert, after insert,before update, after update) 
{
    if(Trigger.isBefore)
    {
        if(Trigger.isInsert)
        {
            OrderTriggerHelper.checkHighValueOrderForApprovalInBeforeInsertCase(Trigger.new);
        }
        
        if(Trigger.isUpdate)
        {
            OrderTriggerHelper.checkHighValueOrderForApprovalInBeforeUpdateCase(Trigger.new, Trigger.oldMap);
        }
    }
    
    if(Trigger.isAfter)
    {
        if(Trigger.IsInsert)
        {
            OrderTriggerHelper.checkHighValueOrderForApprovalInAfterInsertCase(Trigger.new);
        }
        
        if(Trigger.isUpdate)
        {
            OrderTriggerHelper.checkHighValueOrderForApprovalInAfterUpdateCase(Trigger.new, Trigger.oldMap);
        }
    }
}
/**
*
*  Purpose          :	Trigger on Task object.
*
*  Created Date     :  	04/26/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
trigger Trigger_Task on Task (after update) 
{
    if(Trigger.isAfter)
    {
        if(Trigger.isUpdate)
        {
            TaskTriggerHelper.whenTaskOnOrderIsApprovedOrRejected(Trigger.new, trigger.oldMap);
        }
    }
}
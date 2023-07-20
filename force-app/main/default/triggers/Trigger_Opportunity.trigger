/**
*
*  Purpose          :   Trigger on Opportunity object.
*
*  Created Date     :   05/01/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
trigger Trigger_Opportunity on Opportunity (before insert, before update) 
{
    try
    {
        if(Trigger.isbefore)
        {
            if(Trigger.isInsert)
            {
                OpportunityTriggerHelper.limitActiveOpportunityToTwo(Trigger.new);
            }
            else if(Trigger.isUpdate)
            {
                OpportunityTriggerHelper.limitActiveOpportunityToTwoAfterUpdate(Trigger.new, Trigger.oldMap);
            }
        }
    }
    catch(Exception ex)
    {
        System.debug(ex.getCause() + ' : ' + ex.getMessage());
    }
}
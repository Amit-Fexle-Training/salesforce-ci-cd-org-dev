trigger Acc_Trigger on Account (after update) 
{
    try
    {
        if(Trigger.isAfter)
        {
            if(Trigger.isUpdate)
            {
                AccTriggerHelper.updateRelatedOpportunity(Trigger.new, Trigger.oldMap);
            }
        }
    }
    catch(Exception ex)
    {
        System.debug(ex.getCause() + ' ' + ex.getMessage());
    }
}
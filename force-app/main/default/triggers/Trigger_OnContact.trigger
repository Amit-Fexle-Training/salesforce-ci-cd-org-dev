/**
*
*  Purpose          :   Trigger on Contact object.
*
*  Created Date     :   04/28/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
trigger Trigger_OnContact on Contact (before insert) 
{
    try
    {
        if(Trigger.isBefore && Trigger.isInsert)
        {
            //OnContactTriggerHelper.updateStatusFieldOnContact(Trigger.new); 
        }
    }
    Catch(Exception ex)
    {
        System.debug(ex.getCause() + ' : ' + ex.getMessage());
    }
}
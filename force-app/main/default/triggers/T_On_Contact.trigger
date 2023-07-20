/**
*
*  Purpose          :   Trigger on Contact object.
*
*  Created Date     :   24/24/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
trigger T_On_Contact on Contact (before insert) 
{
     try
    {
        if(Utilities.BypassAllTriggers)
        return;
        
        if(Trigger.isBefore)
        {
            if(Trigger.isInsert)
            {
                OnContactTHelper.checkDuplicateWhenNewContactInsert(Trigger.new);
            }
            else if(Trigger.isUpdate)
            {
                OnContactTHelper.checkDuplicateWhenContactIsdUpdate(Trigger.new, Trigger.OldMap);
            }
        }
    }
    catch(exception ex)
    {
        System.debug(ex.getCause() + ' : ' + ex.getMessage());
    }
}
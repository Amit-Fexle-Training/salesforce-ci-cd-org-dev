/**
*
*  Purpose          :   Trigger on Class object.
*
*  Created Date     :   04/07/2022
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
trigger Class_Trigger on Class__c (after insert, after delete, after update) 
{
    try 
    {
        if(Utilities.ByPassAllTriggers || Utilities.areTriggersOnThisObjectBypassed('Class__c'))
            return; 
        
        if(Trigger.isAfter)
        {
            if(/*Trigger.isInsert ||*/ Trigger.isDelete)
            {
                ClassTriggerHelper.updateStatisticsOnSchools(trigger.new, trigger.oldMap);
            }
        }
    }
    catch(Exception e)
    {
        integer i=0;
        if(Trigger.isDelete)
            Trigger.Old[i].addError(e.getMessage());
        else
            Trigger.New[i].addError(e.getMessage());
    } 
}
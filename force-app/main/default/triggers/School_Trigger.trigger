/**
*
*  Purpose          :   Trigger on School object.
*
*  Created Date     :   04/06/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
trigger School_Trigger on School__c (before insert, before update, after update) 
{
    try
    {
       /* if(Utilities.ByPassAllTriggers || Utilities.areTriggersOnThisObjectBypassed(School__c))
        {
            return;
        }
         */
        if(Trigger.isBefore)
        {
            if(Trigger.isInsert || Trigger.isUpdate)
            {
                SchoolTriggerHelper.performValidationLogics(trigger.new, trigger.oldMap);
            }
            
            if(Trigger.isUpdate)
            {
                //SchoolTriggerHelper.updateNoOfStudentsDetailsInBeforeCase(trigger.new, trigger.oldMap);
                //SchoolTriggerHelper.updateNoOfClassesDetailsInBeforeCase(trigger.new, trigger.oldMap);
            }
        }
        
        if(Trigger.isAfter)
        {
            if(Trigger.isUpdate)
            {
                SchoolTriggerHelper.doApexSharingCalculations(trigger.new, trigger.oldMap);
                //SchoolTriggerHelper.updateNoOfStudentsDetails(trigger.new, trigger.oldMap);
                //SchoolTriggerHelper.updateNoOfClassesDetails(trigger.new, trigger.oldMap);
            }
        }
    }
    catch(Exception e )
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
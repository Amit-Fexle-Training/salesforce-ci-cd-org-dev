/**
*
*  Purpose          :   Trigger on Student object.
*
*  Created Date     :   04/07/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
trigger Student_Trigger on Student__c (after insert, after delete, after update) 
{
    try
    {
         if(Utilities.ByPassAllTriggers || Utilities.areTriggersOnThisObjectBypassed(Constants.OBJECT_NAME_STUDENT))
            return; 
        
        if(Trigger.isAfter) 
        {
            if(/*Trigger.isInsert || Trigger.isUpdate || */Trigger.isDelete)
            {
                StudentTriggerHelper.updateNoOfStudentsDetails(trigger.new, trigger.oldMap);
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
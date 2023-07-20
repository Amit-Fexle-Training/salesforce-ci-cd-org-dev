trigger AccountTrigger on Account (before insert, after insert, after update) {
    if(Trigger.isbefore){
        if(Trigger.isInsert){
        AccountTriggerHandler.updateRating(Trigger.new);
    }
    }
    if(Trigger.isAfter){
        if(Trigger.isInsert)
        {
            AccountTriggerHandler.createdRelatedOpp(Trigger.new);
            AccountTriggerHelper.createRelatedContacts(Trigger.new);
        }
        if(Trigger.isDelete)
        {
            AccountTriggerHelper.deleteChildContactsOnParentAccountDelete(Trigger.oldMap);
        }
        if(Trigger.isUpdate)
        {
            AccountTriggerHelper.addAndDeleteRelatedContacts(Trigger.new, Trigger.oldMap);
        }
    }
    
}
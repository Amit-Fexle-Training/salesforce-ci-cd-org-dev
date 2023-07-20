/**
*
*  Purpose          :	Helper Class For Trigger on Task object.
*
*  Created Date     :  	04/26/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class TaskTriggerHelper 
{
    public static void whenTaskOnOrderIsApprovedOrRejected(List<Task> taskList, Map<Id, Task> mapOfOldTask)
    {
        Set<Id> setOfIdOfApprovedOrder = new Set<Id>();
        Set<Id> setOfIdOfRejectedOrder = new Set<Id>();
        if(taskList.size()>0)
        {
            for(Task task : taskList)
            {
                if(task.Type == 'Order__c' && (task.Status != mapOfOldTask.get(task.Id).Status) && (task.Status == 'Completed'))
                {
                    System.debug('11111');
                    if(task.Description.ContainsIgnoreCase('Approved'))
                    {
                        setOfIdOfApprovedOrder.add(task.WhatId);
                    }
                    else if(task.Description.ContainsIgnoreCase('Rejected'))
                    {
                        setOfIdOfRejectedOrder.add(task.WhatId);
                        System.debug('2222');
                    }
                }
            }
            System.debug('@@@ setOfIdOfApprovedOrder: '+setOfIdOfApprovedOrder+'  '+ 'setOfIdOfRejectedOrder : ' + setOfIdOfRejectedOrder);
            List<Order__c> listOfOrderToBeUpdated = new List<Order__c>();
            if(setOfIdOfApprovedOrder.size()>0)
            {
                for(Order__c odr : [SELECT Approval_Status__c, Fulfilment_Status__c FROM Order__c WHERE Id In : setOfIdOfApprovedOrder])
                {
                    odr.Approval_Status__c = 'Approved';
                    odr.Fulfilment_Status__c = 'Pending Fulfilment';
                    listOfOrderToBeUpdated.add(odr);
                }
            }
            
            
            if(setOfIdOfRejectedOrder.size()>0)
            {
                for(Order__c odr : [SELECT Approval_Status__c, Fulfilment_Status__c, Email__c FROM Order__c WHERE Id In : setOfIdOfRejectedOrder])
                {
                    odr.Approval_Status__c = 'Rejected';
                    odr.Fulfilment_Status__c = 'Rejected';
                    
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(new List<String>{ odr.Email__c });
                    mail.setSubject('Order Rejected');
                    mail.setPlainTextBody('Your order has been rejected. ');
                    Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ mail });
                    
                    listOfOrderToBeUpdated.add(odr);
                }
            }
            
            if(listOfOrderToBeUpdated.size()>0)
            {
                Utilities.BypassAllTriggers = true;
                update listOfOrderToBeUpdated;
                Utilities.BypassAllTriggers = false;
            }
            System.debug('@@@ listOfOrderToBeUpdated : ' + listOfOrderToBeUpdated);
        }
    }
}
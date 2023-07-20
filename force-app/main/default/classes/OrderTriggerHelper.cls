/**
*
*  Purpose          :	Helper Class For Trigger on Custom Order object.
*
*  Created Date     :  	04/26/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class OrderTriggerHelper 
{
    
    public static void checkHighValueOrderForApprovalInBeforeInsertCase(List<Order__c> orderList)
    {
        if(orderList.size()>0)
        {
            
            for(Order__c ord : orderList)
            {
                if(ord.Total_Cost__c >= 10000)
                {
                    ord.Approval_Status__c = 'Pending';
                }
                else
                {
                    ord.Approval_Status__c = 'Approved';
                    ord.Fulfilment_Status__c = 'Pending Fulfilment';
                }
            }
            
        }
    }
    
    public static void checkHighValueOrderForApprovalInAfterInsertCase(List<Order__c> orderList)
    {
        if(orderList.size()>0)
        {
            List<Task> listOfTaskToBeAssigned = new List<Task>();
            for(Order__c ord : orderList)
            {
                if(ord.Total_Cost__c >= 10000)
                {
                    Task newTask = new task();
                    newTask.WhatId = ord.Id;
                    newTask.Subject = 'High Value Order';
                    newtask.Priority = 'High';
                    newtask.Type = 'Order__c';
                    newTask.Status = 'New';
                    newTask.OwnerId = '0052w00000CBaTVAA1';
                    listOfTaskToBeAssigned.add(newTask);
                }
            }
            if(listOfTaskToBeAssigned.size()>0)
            {
                Utilities.BypassAllTriggers = true;
                insert listOfTaskToBeAssigned;
                Utilities.BypassAllTriggers = false;
            }
        }
    }
    
    public static void checkHighValueOrderForApprovalInBeforeUpdateCase(List<Order__c> orderList, Map<Id, Order__c> mapOfOldOrder)
    {
        if(orderList.size()>0)
        {
            for(Order__c ord : orderList)
            {
                if(ord.Total_Cost__c != mapOfOldOrder.get(ord.Id).Total_Cost__c)
                {
                    if(ord.Total_Cost__c >= 10000)
                    {
                        ord.Approval_Status__c = 'Pending';
                    }
                    else
                    {
                        ord.Approval_Status__c = 'Approved';
                        ord.Fulfilment_Status__c = 'Pending Fulfilment';
                    }
                }
            }
        }
    }
    
    public static void checkHighValueOrderForApprovalInAfterUpdateCase(List<Order__c> orderList, Map<Id, Order__c> mapOfOldOrder)
    {
        if(orderList.size()>0)
        {
            List<Task> listOfTaskToBeAssigned = new List<Task>();
            for(Order__c ord : orderList)
            {
                if(ord.Total_Cost__c != mapOfOldOrder.get(ord.Id).Total_Cost__c)
                {
                    if(ord.Total_Cost__c >= 10000)
                    {
                        Task newTask = new task();
                        newTask.WhatId = ord.Id;
                        newTask.Subject = 'High Value Order';
                        newtask.Priority = 'High';
                        newtask.Type = 'Order__c';
                        newTask.Status = 'New';
                        newTask.OwnerId = '0052w00000CBaTVAA1';
                        listOfTaskToBeAssigned.add(newTask);
                    }
                    
                }
            }
            
            if(listOfTaskToBeAssigned.size()>0)
            {
                Utilities.BypassAllTriggers = true;
                insert listOfTaskToBeAssigned;
                Utilities.BypassAllTriggers = false;
            }
            
        }
        
    }
}
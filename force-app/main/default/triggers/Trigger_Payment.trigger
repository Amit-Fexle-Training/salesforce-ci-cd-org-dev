/**
*
*  Purpose          :   Trigger on Payment object.
*
*  Created Date     :   04/25/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
trigger Trigger_Payment on Payment__c (after insert, after update) 
{
    if(Trigger.isAfter)
    {
        if(Trigger.isInsert)
        {
            PaymentTriggerHelper.updateInvoiceAfterPaymentRecordInsert(Trigger.new);
        }
        else if(Trigger.isAfter)
        {
            PaymentTriggerHelper.updateInvoiceAfterPaymentRecordUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}
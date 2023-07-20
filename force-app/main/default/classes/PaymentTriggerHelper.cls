/**
*
*  Purpose          :   Helper Class For Trigger on Payment object.
*
*  Created Date     :   04/25/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class PaymentTriggerHelper 
{
    public static void updateInvoiceAfterPaymentRecordInsert(List<Payment__C> paymentList)
    {
        if(paymentList.size()>0)
        {
            Map<Id, Decimal> mapOFInvoiceIdWithAmountPaidField = new Map<Id, Decimal>();
            for(Payment__c pay : paymentList)
            {
                if(pay.Status__c == 'Processed')
                {
                    if(!mapOFInvoiceIdWithAmountPaidField.containskey(pay.Invoice__c))
                    {
                        mapOFInvoiceIdWithAmountPaidField.put(pay.Invoice__c, pay.Amount__c);
                    }
                    else
                    {
                        mapOFInvoiceIdWithAmountPaidField.put(pay.Invoice__c, (mapOFInvoiceIdWithAmountPaidField.get(pay.Invoice__c) + pay.Amount__c));
                    }
                }
            }
            
            List<Invoice__c> listOFInvoiceToBeUpdated = new List<Invoice__c>();
            for(Payment__c pay : paymentList)
            {
                for(Invoice__c inv : [SELECT Id, Status__c, Amount_Paid__c FROM Invoice__c WHERE ID IN : mapOFInvoiceIdWithAmountPaidField.keyset()])
                {
                    if((inv.Amount_Paid__c + mapOFInvoiceIdWithAmountPaidField.get(inv.Id)) >= pay.Amount_Due__c)
                    {
                        inv.Status__c = 'Paid';
                    }
                    else
                    {
                        inv.Status__c = 'Partial Payment';
                    }
                    inv.Amount_Paid__c += mapOFInvoiceIdWithAmountPaidField.get(inv.Id);
                    listOFInvoiceToBeUpdated.add(inv);
                }
                
            }
            
            if(listOFInvoiceToBeUpdated.size()>0)
            {
                Utilities.BypassAllTriggers = true;
                update listOFInvoiceToBeUpdated;
                Utilities.BypassAllTriggers = false;
            }
        }
    }
    
    public static void updateInvoiceAfterPaymentRecordUpdate(List<Payment__c> paymentList, Map<Id, Payment__c> mapOFOldPayment)
    {
        if(paymentList.size()>0)
        {
            Map<Id, Decimal> mapOFInvoiceIdWithAmountPaidField = new Map<Id, Decimal>();
            for(Payment__c pay : paymentList)
            {
               if((pay.Status__c != mapOfOldPayment.get(pay.Id).Status__c) && pay.Status__c == 'Processed')
               {
                   if(!mapOFInvoiceIdWithAmountPaidField.containskey(pay.Invoice__c))
                    {
                        mapOFInvoiceIdWithAmountPaidField.put(pay.Invoice__c, pay.Amount__c);
                    }
                    else
                    {
                        mapOFInvoiceIdWithAmountPaidField.put(pay.Invoice__c, (mapOFInvoiceIdWithAmountPaidField.get(pay.Invoice__c) + pay.Amount__c));
                    }
               }
            }
            
            List<Invoice__c> listOFInvoiceToBeUpdated = new List<Invoice__c>();
            for(Payment__c pay : paymentList)
            {
                if((pay.Status__c != mapOfOldPayment.get(pay.Id).Status__c) && pay.Status__c == 'Processed')
                {
                    for(Invoice__c inv : [SELECT Id, Status__c, Amount_Paid__c FROM Invoice__c WHERE ID IN : mapOFInvoiceIdWithAmountPaidField.keyset()])
                    {
                        if((inv.Amount_Paid__c + mapOFInvoiceIdWithAmountPaidField.get(inv.Id)) >= pay.Amount_Due__c)
                    {
                        inv.Status__c = 'Paid';
                    }
                    else
                    {
                        inv.Status__c = 'Partial Payment';
                    }
                    inv.Amount_Paid__c += mapOFInvoiceIdWithAmountPaidField.get(inv.Id);
                    listOFInvoiceToBeUpdated.add(inv);
                    }
                }
            }
            if(listOFInvoiceToBeUpdated.size()>0)
            {
                Utilities.BypassAllTriggers = true;
                update listOFInvoiceToBeUpdated;
                Utilities.BypassAllTriggers = false;
            }
        }
    }
}
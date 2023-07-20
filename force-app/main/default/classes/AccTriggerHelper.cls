public without sharing class AccTriggerHelper 
{
    public static void updateRelatedOpportunity(List<Account> accountList, Map<Id, Account> mapOfOldAccount)
    {
        Set<Id> accountId = new Set<Id>();
        for(Account acc : accountList)
        {
            if((acc.Active__c != mapOfOldAccount.get(acc.Id).Active__c) && mapOfOldAccount.get(acc.Id).Active__c == 'Yes')
            {
                accountId.add(acc.Id);
            }
        }
        
        if(accountId.size()>0)
        {
            List<Opportunity> listOfOpportunityToBeUpdated = [SELECT Id, StageName FROM Opportunity WHERE AccountId IN :accountId AND StageName != 'Closed Won'];
            for(Opportunity opp : listOfOpportunityToBeUpdated)
            {
                opp.StageName = 'Closed Lost';
            }
            
            if(listOfOpportunityToBeUpdated.size()>0)
            {
                update listOfOpportunityToBeUpdated;
            }
        }
    }
}
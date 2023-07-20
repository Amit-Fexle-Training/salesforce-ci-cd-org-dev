/**
*
*  Purpose          :   Helper Class For Trigger_Opportunity class.
*
*  Created Date     :   05/01/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class OpportunityTriggerHelper 
{
    public static void limitActiveOpportunityToTwo(List<Opportunity> opportunityList)
    {
        if(opportunityList.size()>0)
        {
            Set<Id> setOfRelatedAccountIds = new Set<Id>();
            Map<Id, Integer> mapOfRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount = new Map<Id, integer>();
            for(Opportunity opp : opportunityList)
            {
                if(opp.AccountId != null)
                {
                    setOfRelatedAccountIds.add(opp.AccountId);
                }
            }
            
            for(Account acc : [SELECT Id, (SELECT Id, Active__c FROM Opportunities WHERE Active__c = true) FROM Account WHERE Id IN : setOfRelatedAccountIds])
            {
                mapOfRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.put(acc.Id, acc.Opportunities.size());
            }
            
            for(Id acc : mapOfRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.keyset())
            {
                Integer count = 0;
                for(Opportunity opp : opportunityList)
                {
                    if(acc == opp.AccountId)
                    {
                        if(mapOfRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.get(acc) >= 2 && opp.Active__c == true)
                        {
                            opp.addError('Account Already Have 2 Active Opportunity');
                        }
                        else if(mapOfRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.get(acc) < 2)
                        {
                            count = mapOfRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.get(acc);
                            if(count < 2 )
                            {
                                if(opp.Active__c == false)
                                {
                                    opp.addError('Opportunity is Inactive');
                                }
                                else
                                {
                                    count++;
                                }
                            }
                            else if(count >= 2 && opp.Active__c == true)
                            {
                                opp.addError('Account Already Have 2 Active Opportunity');
                            }
                        }
                    }
                }
            }
        }
    }
    
    public static void limitActiveOpportunityToTwoAfterUpdate(List<Opportunity> opportunityList, Map<Id, Opportunity> mapOfOldOpportunity)
    {
        if(opportunityList.size() > 0)
        {
            Set<Id> setOfNewRelatedAccountIds = new Set<Id>();
            
            Map<Id, Integer> mapOfNewRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount = new Map<Id, Integer>();
            
            for(Opportunity opp : opportunityList)
            {
                if(opp.Active__c != mapOfOldOpportunity.get(opp.Id).Active__c || opp.AccountId != mapOfOldOpportunity.get(opp.Id).AccountId)
                {
                    setOfNewRelatedAccountIds.add(opp.AccountId);
                    
                }
            }
            
            for(Account acc : [SELECT Id, (SELECT Id, Active__c FROM Opportunities WHERE Active__c = true) FROM Account WHERE Id IN : setOfNewRelatedAccountIds])
            {
                mapOfNewRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.put(acc.Id, acc.Opportunities.size());
            }
            
            
            
            for(Id acc : mapOfNewRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.keySet())
            {
                Integer count = 0;
                for(Opportunity opp : opportunityList)
                {
                    if(opp.Active__c != mapOfOldOpportunity.get(opp.Id).Active__c )
                    {
                        if(mapOfNewRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.get(acc) >= 2 && opp.Active__c == true)
                        {
                            opp.addError('Account Already Have 2 Active Opportunity');
                        }
                        else if(mapOfNewRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.get(acc) < 2)
                        {
                            count = mapOfNewRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.get(acc);
                            if(count < 2 )
                            {
                                if(opp.Active__c == false)
                                {
                                    opp.addError('Opportunity is Inactive');
                                }
                                else
                                {
                                    count++;
                                }
                            }
                            else if(count >= 2 && opp.Active__c == true)
                            {
                                opp.addError('Account Already Have 2 Active Opportunity');
                            }
                        }
                    }
                    else if(opp.AccountId != mapOfOldOpportunity.get(opp.Id).AccountId)
                    {
                        if(mapOfNewRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.get(acc) >= 2 && opp.Active__c == true)
                        {
                            opp.addError('Account Already Have 2 Active Opportunity');
                        }
                        else if(mapOfNewRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.get(acc) < 2)
                        {
                            count = mapOfNewRelatedAccountIdsAndNoOfRelatedActiveOpportunityCount.get(acc);
                            if(count < 2 )
                            {
                                if(opp.Active__c == false)
                                {
                                    opp.addError('Opportunity is Inactive');
                                }
                                else
                                {
                                    count++;
                                }
                            }
                            else if(count >= 2 && opp.Active__c == true)
                            {
                                opp.addError('Account Already Have 2 Active Opportunity');
                            }
                        }
                    }
                }
            }
        }
    }
}
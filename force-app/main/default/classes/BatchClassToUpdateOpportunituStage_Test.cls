/*
* Purpose : Test Class For BatchClassToUpdateOpportunituStage
* 
* Created By : Amit Kumar
* 
* Created Date : 04/27/2023
* 
* Version : v_0.1 - created 
* 
*/
@isTest(seeAllData=false)
public without sharing class BatchClassToUpdateOpportunituStage_Test 
{
    @testSetup
    public static void setup()
    {
        List<Opportunity> listOfOpportunity = (List<Opportunity>)SmartFactory.createSObjectList('Opportunity', false, 5);
        for(Opportunity opp : listOfOpportunity)
        {
            opp.Amount = 15000;
        }
        Utilities.BypassAllTriggers = true;
        insert listOfOpportunity;
        Utilities.BypassAllTriggers = false;
        System.assertEquals(5, listOfOpportunity.size());
    }
    
    @isTest(seeAllData=false)
    public Static void testBatchClassToUpdateOpportunituStage()
    {
        List<Opportunity> listOfOpportunity = [SELECT Id, Amount, StageName FROM Opportunity WHERE Amount >= 10000];
        System.assertEquals(5, listOfOpportunity.size());
        
        Test.startTest();
        Database.executeBatch(new BatchClassToUpdateOpportunituStage(), 200);
        //System.schedule('jobName', '0 11 20 * * ? *', new BatchClassToUpdateOpportunituStage());
        Test.stopTest();
        
        List<Opportunity> listOfUpdatedOpportunity = [SELECT Id, Amount, StageName FROM Opportunity WHERE Amount >= 10000 AND StageName='Closed Won'];
        System.assertEquals(5, listOfUpdatedOpportunity.size());
        
    }
}
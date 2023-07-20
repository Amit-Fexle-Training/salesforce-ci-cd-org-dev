/*
* Purpose : Test Class For BatchClassToProcessOpportunity Apex Class.
* 
* Created By : Amit Kumar
* 
* Created Date : 04/24/2023
* 
* Version : v_0.1 - created 
* 
*/
@isTest(seeAllData=false)
public without sharing class BatchClassToProcessOpportunity_Test 
{
    @testSetup
    public static void setup()
    {
        List<Opportunity> listOfOpportunity = new List<Opportunity>();
        Opportunity opp1 = new Opportunity(Name='New Opp 1',StageName='Prospecting', CloseDate=System.today(), Probability=86);
        Opportunity opp2 = new Opportunity(Name='New Opp 2',StageName='Prospecting', CloseDate=System.today(), Probability=66);
        Opportunity opp3 = new Opportunity(Name='New Opp 3',StageName='Prospecting', CloseDate=System.today(), Probability=6);
        listOfOpportunity.add(opp1);
        listOfOpportunity.add(opp2);
        listOfOpportunity.add(opp3);
        if(listOfOpportunity.size()>0)
        {
            insert listOfOpportunity;
        }
    }
    
    @isTest(seeAllData=false)
    public static void testBatchClassToProcessOpportunity()
    {
        Test.startTest();
        System.schedule('ScheduleBatchJob', '0 0 2 * * ? *', new BatchClassToProcessOpportunity());
        //BatchClassToProcessOpportunity bc = new BatchClassToProcessOpportunity();
        //Database.executeBatch(bc, 5);
        Test.stopTest();
        List<Opportunity> listOfBatchedProcessedOpportunity = [SELECT Id, StageName, Probability FROM Opportunity];
        system.assertEquals(3, listOfBatchedProcessedOpportunity.size());
        for(Opportunity opp : listOfBatchedProcessedOpportunity)
        {
            if(opp.Probability >= 75)
            {
                System.assertEquals('Closed Won', opp.StageName);
            }
            else if(opp.Probability>=50 && opp.Probability<75)
            {
                System.assertEquals('Negotiation/Review', opp.StageName);
            }
            else
            {
                System.assertEquals('Prospecting', opp.StageName);
            }
        }
    }
}
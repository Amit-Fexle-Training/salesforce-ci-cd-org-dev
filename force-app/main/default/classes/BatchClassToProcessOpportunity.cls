/*
* Purpose : Write the batch class with given requirment
			=> The batch should be executed at a specific time each day, such as 2:00 AM.
			=> The batch should only process Opportunities that meet certain criteria, such as those that have been modified in       the last 24 hours.
			=> The batch should log any errors that occur during processing
			=> The batch should update the Stage field on each Opportunity record to a new value based on certain criteria.
			=> The new value for the Stage field should be determined based on the Opportunity's Probability field.
			=> If the Probability is greater than or equal to 75%, the Stage should be set to "Closed Won".
			=> If the Probability is between 50% and 75%, the Stage should be set to "Negotiation/Review".
			=> If the Probability is less than 50%, the Stage should be set to "Prospecting".
* 
* Created By : Amit Kumar
* 
* Created Date : 04/24/2023
* 
* Version : v_0.1 - created 
* 
*/ 
Global without sharing class BatchClassToProcessOpportunity implements database.Batchable<sobject>, Schedulable, Database.Stateful 
{
    
    public database.QueryLocator start(Database.BatchableContext bc)
    {
        return database.getQueryLocator('SELECT Id, StageName, Probability FROM Opportunity WHERE LastModifiedDate >= Last_N_Days:1');
    }
    
    public void execute(Database.BatchableContext bc, List<Opportunity> opportunityList)
    {
        try
        {
            if(opportunityList.size()>0)
            {
                List<Opportunity> listOfOpportunityToBeUpdated = new List<opportunity>();
                for(Opportunity opp : opportunityList)
                {
                    if(opp.Probability>=75)
                    {
                        opp.StageName = 'Closed Won';
                    }
                    else if(opp.Probability>=50 && opp.Probability<75)
                    {
                        opp.StageName = 'Negotiation/Review';
                    }
                    else
                    {
                        opp.StageName = 'Prospecting';
                    }
                    listOfOpportunityToBeUpdated.add(opp);
                }
                
                if(listOfOpportunityToBeUpdated.size()>0)
                {
                    Database.SaveResult[] srList = Database.update(listOfOpportunityToBeUpdated,false);
                    for(Database.SaveResult sr : srlist)
                    {
                        if(!sr.isSuccess())
                        {
                            for(Database.Error err : sr.getErrors())
                            {
                                System.debug(err.getStatusCode()+ ':' + err.getMessage());
                            }
                        }
                    }
                }
            }
        }
        catch(exception e)
        {
            System.debug('Error While Processing Batch Job' + e.getCause() + ' : ' + e.getMessage());
        }
    }
    
    public void finish(Database.BatchableContext bc)
    {
        
    }
    
    public void execute(SchedulableContext sc)
    {
        System.schedule('ScheduleBatchJob', '0 0 2 * * ? *', new BatchClassToProcessOpportunity());
    }
}

// System.schedule('ScheduleBatchJob', '0 0 2 * * ? *', new new BatchClassToProcessOpportunity());
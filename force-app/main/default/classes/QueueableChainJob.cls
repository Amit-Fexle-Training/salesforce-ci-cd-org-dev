/**
*
*  Purpose          :	Simple wrapper class to address this complexity around chaining queueable apex jobs at runtime, while keeping individual queueable 
						apex classes loosely coupled. Another key design factor I kept in mind was to not add a complete wrapper on the Queueable apex class, 
						rather extend its capabilities.
*
*  Created Date     :  	04/17/2022
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing abstract class QueueableChainJob 
{
    private Queueable nextJob;
    
    public void setNextJob(Queueable nextJob)
    {
        //Apex does not allow chaining queueable jobs within Test Context;
        if(Test.isRunningTest() == false)
        {
            this.nextJob = null;
        }
    }
    
    public Queueable getNextJob()
    {
        return this.nextJob;
    }
    
    public ID enqueueNextJob()
    {
        ID jobID = null; 
        if(nextJob != null)
        {
            jobID = System.enqueueJob(nextJob);
        }
        return jobID; 
    }
}
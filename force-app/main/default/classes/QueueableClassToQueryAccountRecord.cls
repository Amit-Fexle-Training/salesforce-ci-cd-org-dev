/*
* Purpose : Queueable Class To Get Account Record That Are Not Related With Any Contact Record.
* 
* Created By : Amit Kumar
* 
* Created Date : 04/27/2023
* 
* Version : v_0.1 - created 
* 
*/
public class QueueableClassToQueryAccountRecord implements queueable
{
    public void execute(QueueableContext context)
    {
        List<Account> acc = [SELECT Id, Name FROM Account];
        System.debug(acc);
    }
    
}
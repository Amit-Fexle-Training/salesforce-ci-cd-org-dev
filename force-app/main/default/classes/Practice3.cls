public class Practice3 {
    
    public static void sampleMethod()
    {
        List<Account> listOfAccount = new List<Account>();
        For(Integer i=1; i<=5;i++)
        {
            Account acc = new Account(name='aaabbb');
            listOfAccount.add(acc);
        }

        insert listOfAccount;

        List<Account> listOfAccountToBelock = [SELECT Id FROM Account WHERE Name='aaabbb'];
        Approval.LockResult[] lrList = Approval.lock(listOfAccountToBelock, false);
        
        for(Approval.LockResult lr : lrList)
        {
            if (lr.isSuccess()) 
            {
                // Operation was successful, so get the ID of the record that was processed
                System.debug('Successfully locked account with ID: ' + lr.getId());
            }
            else
            {
                // Operation failed, so get all errors                
                for(Database.Error err : lr.getErrors())
                {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }
        }
    } 
}
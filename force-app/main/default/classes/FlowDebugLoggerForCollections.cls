public with sharing class FlowDebugLoggerForCollections 
{
    @InvocableMethod(label='Log Debug Message (Collections)' description='Outputs messages to the debug log for Collections')
    public static void trace(List<List<String>> listOfDebugMessages) 
    {
        for (List<String> debugMessages : listOfDebugMessages) 
        {
            System.debug('@@@@@ debugMessages ' + debugMessages);
            for(String debugMessage : debugMessages) 
            {
                System.debug('@@@@@ debugMessage ' + debugMessage);    
            }
        }
    }
}
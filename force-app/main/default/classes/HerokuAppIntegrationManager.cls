/**
*
*  Purpose          :	Helper Class for integration with Open Source Heroku App.
*
*  Created Date     :  	04/11/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class HerokuAppIntegrationManager 
{
    @future(callout=true)
    public static void makeCalloutToHerokuAndUpdateUsers(Set<Id> schoolsIds)
    {
        if(schoolsIds != null && schoolsIds.size() > 0)
        {
            HerokuAppIntegrationManager.makeHerokuAppCalloutAndUpdateUsers(schoolsIds);
        }
    }
    //Method to make callout via future apex
    /**
    public static void makeHerokuAppCalloutAndUpdateUsers(Set<Id> schoolsIds)
    {
       if(schoolsIds != null && schoolsIds.size()>0)
       {
           Http http = new Http();
           
           HttpRequest request = new HttpRequest();
           request.setEndpoint(System.Label.ENDPOINT_HEROKu_APP);
           request.setMethod(Constants.HTTP_CALLOUT_OPERATION_GET);
           
           HttpResponse response = http.send(request);
           
           //Parsing the JSON response when request is sucessful
           if(response.getStatusCode() == Constants.HTTP_CALLOUT_SUCCESS_CODE)
           {
               List<User> integrationUserDetails = [SELECT Id, Heroku_App_Response__c 
                                                         FROM User 
                                                         WHERE Id =: System.Label.INTEGRATION_USER_RECORD_ID
                                                         AND IsActive = true
                                                        ];
               if(integrationUserDetails.size() > 0)
               {
                   if(response.getBody() != null)
                   {
                       String tempResponse = Constants.CHAR_BLANK;
                       for(Id schId : schoolsIds)
                       {
                           tempResponse += schId + Constants.CHAR_BLANK_SPACE;
                       }
                       
                       // Deserialize the JSON string into collections of primitive data types.
                       Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                       
                       // Cast the values in the 'animals' key as a list
                       List<Object> animals = (List<Object>) results.get(Constants.CHAR_ANIMALS);
                       
                       for(Object animal: animals) 
                            {
                                tempResponse += Constants.CHAR_BLANK_SPACE + Constants.CHAR_DASH + Constants.CHAR_BLANK_SPACE + animal;
                            }
                       
                       integrationUserDetails[0].Heroku_App_Response__c = tempResponse;
                       
                       Utilities.BypassAllTriggers = true;
                       update integrationUserDetails;   
                       Utilities.BypassAllTriggers = false;
                   }
               }
           }
       }
    }
*/
    
    public static WebServiceLogsWrapper makeHerokuAppCalloutAndUpdateUsers(Set<Id> schoolsIds) 
    {
        WebServiceLogsWrapper webServiceLogsWrapper = new WebServiceLogsWrapper();
        webServiceLogsWrapper.isSuccessfullyExecuted = false;
        
        try 
        {
            if(schoolsIds != null && schoolsIds.size() > 0) 
            {
                //Without Framework
                /*Http http = new Http();
                
                HttpRequest request = new HttpRequest();
                request.setEndpoint(System.Label.ENDPOINT_HEROKU_APP);
                request.setMethod(Constants.HTTP_CALLOUT_OPERATION_GET);
                
                HttpResponse response = http.send(request);*/
                
                //With Framework
                HttpCalloutService service = new HTTPCalloutService(Constants.HTTP_CALLOUT_NAME_HEROKU_APP_GET_ANIMALS);
                HTTPResponse response = service.sendRequest();
                
                // If the request is successful, parse the JSON response.
                if(response.getStatusCode() == Constants.HTTP_CALLOUT_SUCCESS_CODE) 
                {
                    List<User> integrationUserDetails = [SELECT Id, Heroku_App_Response__c 
                                                         FROM User 
                                                         WHERE Id =: System.Label.INTEGRATION_USER_RECORD_ID
                                                         AND IsActive = true
                                                        ];
                    
                    if(integrationUserDetails.size() > 0) 
                    {
                        if(response.getBody() != null) 
                        {
                            webServiceLogsWrapper.direction = Constants.HTTP_CALLOUT_DIRECTION_SF_TO_HEROKU;
                            webServiceLogsWrapper.endpoint = System.Label.ENDPOINT_HEROKU_APP;
                            webServiceLogsWrapper.errorMessage = Constants.CHAR_BLANK;
                            webServiceLogsWrapper.recordID = integrationUserDetails[0].Id;
                            webServiceLogsWrapper.requestMessage = Constants.CHAR_BLANK;
                            webServiceLogsWrapper.requestMessageLog = service.getRequestBody();
                            webServiceLogsWrapper.requestSent = System.now();
                            webServiceLogsWrapper.responseMessage = Constants.HTTP_CALLOUT_STATUS_SUCCESS;
                            webServiceLogsWrapper.responseMessageLog = response.getBody();
                            webServiceLogsWrapper.responseReceived = System.now();
                            webServiceLogsWrapper.webServiceClass = Constants.HEROKU_APP_INTEGRATION_CLASS_NAME;
                            webServiceLogsWrapper.webServiceMethod = Constants.HTTP_CALLOUT_OPERATION_GET;
                            webServiceLogsWrapper.webServiceName = Constants.HEROKU_UPDATE_USERS_METHOD_NAME;
                    
                            String tempResponse = Constants.CHAR_BLANK;
                            for(ID schId : schoolsIds) 
                            {
                                tempResponse += schId + Constants.CHAR_BLANK_SPACE;
                            }
                            
                            // Deserialize the JSON string into collections of primitive data types.
                            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                            
                            // Cast the values in the 'animals' key as a list
                            List<Object> animals = (List<Object>) results.get(Constants.CHAR_ANIMALS);
                            
                            for(Object animal: animals) 
                            {
                                tempResponse += Constants.CHAR_BLANK_SPACE + Constants.CHAR_DASH + Constants.CHAR_BLANK_SPACE
                                    + animal;
                            }
                            integrationUserDetails[0].Heroku_App_Response__c = tempResponse;
                            
                            Utilities.BypassAllTriggers = true;
                            update integrationUserDetails;   
                            Utilities.BypassAllTriggers = false;
                            
                            webServiceLogsWrapper.isSuccessfullyExecuted = true;
                        }
                        else 
                        {
                            webServiceLogsWrapper.isSuccessfullyExecuted = false;
                        }
                    }
                    else 
                    {
                    	webServiceLogsWrapper.isSuccessfullyExecuted = false;    
                    }
                }
                else 
                {
                	webServiceLogsWrapper.isSuccessfullyExecuted = false;    
                }
            }
            else 
            {
                webServiceLogsWrapper.isSuccessfullyExecuted = false;	    
            }
        }
        catch(Exception ex) 
        {
            webServiceLogsWrapper.isSuccessfullyExecuted = false;
        }
        return webServiceLogsWrapper;
    }
}
/**
*
*  Purpose          :   Apex class that is having methods to make various types of Custom REST API callouts on Web Service Logs Object.
*						https://trailhead.salesforce.com/content/learn/modules/apex_integration_services/apex_integration_webservices
						https://json2apex.herokuapp.com/
*
*  Created Date     :   04/20/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
//"/services/apexrest/WebServiceLogs/v1"
@RestResource(urlMapping='/WebServiceLogs/v1/*')
global with sharing class RestResource_WebServiceLogs 
{
    String x = 'some string'; // not used

    /*Annotation	Action	Details
    @HttpGet	Read	Reads or retrieves records.
    @HttpPost	Create	Creates records.
    @HttpDelete	Delete	Deletes records.
    @HttpPut	Upsert	Typically used to update existing records or create records.
    @HttpPatch	Update	Typically used to update fields in existing records.*/
    
    //DELETE + "/services/apexrest/WebServiceLogs/v1/a075g000005zzQ4"
    @HttpDelete
    global static String doDelete() 
    {
        String result = Constants.CHAR_BLANK;
        try 
        {
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
            if(req != null && req.requestURI != null) 
            {
                String webServiceLogId = req.requestURI.substring(req.requestURI.lastIndexOf(Constants.CHAR_BACK_SLASH)+1);
                if(String.isNotBlank(webServiceLogId)) 
                {
                    List<Web_Service_Log__c> listOfWebServiceLogs = [SELECT Id 
                                                                     FROM Web_Service_Log__c 
                                                                     WHERE Id =: webServiceLogId];
                    if(listOfWebServiceLogs.size() > 0) 
                    {
                        if(Schema.sObjectType.Web_Service_Log__c.isDeletable()) 
                        {
                            delete listOfWebServiceLogs;
                            result = Constants.CHAR_RECORD_DELETED_SUCCESSFULLY;
                        }
                        else 
                        {
                            result = 'You have not have web service log object delete access.';
                        }
                    }
                    else 
                    {
                    	result = Constants.ERROR_UNABLE_TO_FIND_RECORD;    
                    }
                }
                else 
                {
                	result = Constants.CHAR_ARE_YOU_KIDDING;     
                }
            }
            else 
            {
                result = Constants.CHAR_ARE_YOU_KIDDING;     
            }
            return result;
        }
        catch(Exception ex) 
        {
            result = (Constants.CHAR_ERROR_WITH_COLON + ex.getMessage());
            return result;    
        }
    }
    
    //"/services/apexrest/WebServiceLogs/v1/a075g000005zzPp" + GET
    @HttpGet
    global static Web_Service_Log__c doGet() 
    {
        Web_Service_Log__c webServiceLog = new Web_Service_Log__c();
        try 
        {
            RestRequest req = RestContext.request;
            RestResponse res = RestContext.response;
            
            if(req != null && req.requestURI != null) 
            {
                String webServiceLogId = req.requestURI.substring(req.requestURI.lastIndexOf(Constants.CHAR_BACK_SLASH)+1);
                if(String.isNotBlank(webServiceLogId)) 
                {
                    List<Web_Service_Log__c> listOfWebServiceLogs = [SELECT Id, Name, Direction__c, 
                                                                     Endpoint__c, Error_Message__c,
                                                                     Record_ID__c, Request_Message__c,
                                                                     Request_Message_Log__c, Request_Sent__c,
                                                                     Response_Message__c, 
                                                                     Response_Message_Log__c,
                                                                     Response_Received__c, 
                                                                     Web_Service_Class__c,
                                                                     Web_Service_Method__c,
                                                                     Web_Service_Name__c
                                                                     FROM Web_Service_Log__c 
                                                                     WHERE Id =: webServiceLogId];
                    if(listOfWebServiceLogs.size() > 0) 
                    {
                        webServiceLog = listOfWebServiceLogs[0];
                    }
                    else 
                    {
                        webServiceLog.Error_Message__c = Constants.ERROR_UNABLE_TO_FIND_RECORD;
                    }
                }
                else 
                {
                    webServiceLog.Error_Message__c = Constants.CHAR_ARE_YOU_KIDDING;
                }
            }
            else 
            {
                webServiceLog.Error_Message__c = Constants.CHAR_ARE_YOU_KIDDING;
            }
            return webServiceLog;
        }
        catch(Exception ex) 
        {
            webServiceLog.Error_Message__c = (Constants.CHAR_ERROR_WITH_COLON + ex.getMessage());
            return webServiceLog;
        }
    }
    
    @HttpPost
    global static String doPost() 
    {
        String responseStr = Constants.CHAR_BLANK;
        
        try 
        {
            RestRequest request = RestContext.request;
            RestResponse response = RestContext.response;    
            response.addHeader(Constants.HEADER_ATTRIBUTE_CONTENT_TYPE, Constants.HEADER_CONTENT_TYPE_APPLICATION_JSON);
            
            if(request.requestBody != null && String.isNotBlank(request.requestBody.toString())) 
            {
                WebServiceLogsRESTParser resultWrapper = WebServiceLogsRESTParser.parse(request.requestBody.toString());
                if(resultWrapper != null) 
                {
                    Web_Service_Log__c webServiceLog = new Web_Service_Log__c();
                    webServiceLog.Direction__c = resultWrapper.Direction;
                    webServiceLog.Endpoint__c  = resultWrapper.Endpoint;
                    webServiceLog.Error_Message__c  = resultWrapper.Error_Message;
                    webServiceLog.Record_ID__c  = resultWrapper.recordID;
                    webServiceLog.Request_Message__c  = resultWrapper.Request_Message;
                    webServiceLog.Request_Message_Log__c  = resultWrapper.Request_Message_Log;
                    webServiceLog.Request_Sent__c  = System.now();
                    webServiceLog.Response_Message__c  = resultWrapper.Response_Message;
                    webServiceLog.Response_Message_Log__c = resultWrapper.Response_Message_Log;
                    webServiceLog.Response_Received__c  = System.now();
                    webServiceLog.Web_Service_Class__c  = resultWrapper.Web_Service_Class;
                    webServiceLog.Web_Service_Method__c  = resultWrapper.Web_Service_Method;
                    webServiceLog.Web_Service_Name__c  = resultWrapper.Web_Service_Name;

                    if(Schema.sObjectType.Web_Service_Log__c.isCreateable()) 
                    {
                        insert webServiceLog;
                        responseStr = Constants.CHAR_SUCCESS_WITH_COLON + webServiceLog.Id;
                    }
                    else 
                    {
                        responseStr = 'You have not have web service log object create access.';
                    }
                }
            }
            else 
            {
                responseStr = Constants.CHAR_ARE_YOU_KIDDING;
            }
            return responseStr;        
        }
        catch(Exception ex) 
        {
            return (Constants.CHAR_ERROR_WITH_COLON + ex.getMessage());    
        }
    }
}
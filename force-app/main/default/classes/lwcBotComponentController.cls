/**
*
*  Purpose          :   Apex class to have business logics related to "lwcBotComponent" LWC component.
*
*  Created Date     :   06/20/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public with sharing class lwcBotComponentController 
{
    private static final String API_KEY = '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';
    private static final String ENDPOINT_URL = 'https://api.openai.com/v1/chat/completions';
    private static final String ENDPOINT_URL_GPT_Image = 'https://api.openai.com/v1/images/generations';
    
    @AuraEnabled(cacheable=false)
    public static String getResponse(String messageText)
    {
        try
        {
            //Generating Http POST Request
            HttpRequest req = new HttpRequest();
            req.setEndpoint(ENDPOINT_URL);
            req.setMethod('POST');
            req.setTimeout(1000*120); //Set Timeout Period For 2 min
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', 'Bearer ' + API_KEY); // Add the API key to the request header
            
            String prompt = messageText;
            System.debug(prompt); 
            
            Map<String, Object> PromptBody = new Map<String, Object>();
            PromptBody.put('role','user');
            PromptBody.put('content',messageText);
            
            List<Object> Prompts = new List<Object>();
            Prompts.add(PromptBody);
            
            Map<String, Object> requestBody = new Map<String, Object>();
            requestBody.put('messages', Prompts);
            requestBody.put('model', 'gpt-3.5-turbo');
            //requestBody.put('max_tokens', 50);
            //requestBody.put('n', 1);
            //requestBody.put('stop', new List<String>{'\n'});
            
            req.setBody(JSON.serialize(requestBody));
            System.debug('Request Body: ' + req.getBody());
            
            Http http = new Http();
            HttpResponse res = http.send(req);
            
            if (res.getStatusCode() == 200) 
            {
                System.debug(res.getBody());
                Map<String, Object> responseBody = (Map<String, Object>)JSON.deserializeUntyped(res.getBody());
                List<Object> choices = (List<Object>)responseBody.get('choices');
                if (choices.size() > 0) {
                    Map<String, Object> choice = (Map<String, Object>)choices.get(0);
                    Map<String,Object> mpMessages = (Map<String,Object>)choice.get('message');
                    
                    String responseText = (String)mpMessages.get('content');
                    
                    responseText = responseText != null ? responseText.trim() : '';
                    system.debug('Response Text: ' + responseText);
                    return responseText;
                }
            } 
            else 
            {
                System.debug('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
            }
            
            return '';
        }
        catch(Exception ex)
        {
            System.debug(ex.getCause() + ' : ' + ex.getMessage());
            return '';
        }
    }
    
    @AuraEnabled(cacheable=false)
    public static List<String> getImage(String messageText)
    {
        try
        {
            //Generating Http POST Request
            HttpRequest req = new HttpRequest();
            req.setEndpoint(ENDPOINT_URL_GPT_Image);
            req.setMethod('POST');
            req.setTimeout(1000*120); //Set Timeout Period For 5 min
            req.setHeader('Content-Type', 'application/json');
            req.setHeader('Authorization', 'Bearer ' + API_KEY); // Add the API key to the request header
            
            Map<String, Object> requestBody = new Map<String, Object>();
            requestBody.put('prompt', messageText);
            requestBody.put('n', 3);
            requestBody.put('size', '256x256');
            
            req.setBody(JSON.serialize(requestBody));
            System.debug('Request Body: ' + req.getBody());
            
            Http http = new Http();
            HttpResponse res = http.send(req);
            
            if (res.getStatusCode() == 200) 
            {
                System.debug(res.getBody());
                Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
                
                Integer created = (Integer) responseBody.get('created');
                List<Object> dataList = (List<Object>) responseBody.get('data');
                
                List<String> urls = new List<String>();
                for (Object obj : dataList) 
                {
                    Map<String, Object> dataMap = (Map<String, Object>) obj;
                    String url = (String) dataMap.get('url');
                    urls.add(url);
                }
                System.debug('urls : ' + urls);
                return urls;
            }
            else 
            {
                System.debug('Error: ' + res.getStatusCode() + ' ' + res.getStatus());
            }
            
            return null;
        }
        catch(Exception ex)
        {
            System.debug(ex.getCause() + ' : ' + ex.getMessage());
            return null;
        }
    }
}
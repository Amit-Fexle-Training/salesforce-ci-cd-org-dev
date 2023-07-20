/**
*
*  Purpose          :   JSON Parser class for Web Service Log REST Responses.
*
*  Created Date     :   04/20/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class WebServiceLogsRESTParser 
{
	public String Direction {get;set;} 
	public String Endpoint {get;set;} 
	public String Error_Message {get;set;} 
	public String Request_Message {get;set;} 
	public String Request_Message_Log {get;set;} 
	public String Response_Message {get;set;} 
	public String Response_Message_Log {get;set;} 
	public String Web_Service_Class {get;set;} 
	public String Web_Service_Method {get;set;} 
	public String Web_Service_Name {get;set;} 
	public DateTime Request_Sent {get;set;} 
	public DateTime Response_Received {get;set;} 
	public String recordID {get;set;} 

	public WebServiceLogsRESTParser(JSONParser parser) 
    {
        while (parser.nextToken() != System.JSONToken.END_OBJECT) 
        {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) 
			{
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) 
                {
					if (text == Constants.FIELD_NAME_DIRECTION) 
                    {
						Direction = parser.getText();
					} else if (text == Constants.FIELD_NAME_ENDPOINT) 
                    {
						Endpoint = parser.getText();
					} 
                    else if (text == Constants.FIELD_NAME_ERROR_MESSAGE) 
                    {
						Error_Message = parser.getText();
					} 
                    else if (text == Constants.FIELD_NAME_REQUEST_MESSAGE) 
                    {
						Request_Message = parser.getText();
					} 
                    else if (text == Constants.FIELD_NAME_REQUEST_MESSAGE_LOG) 
                    {
						Request_Message_Log = parser.getText();
					} 
                    else if (text == Constants.FIELD_NAME_RESPONSE_MESSAGE) 
                    {
						Response_Message = parser.getText();
					} 
                    else if (text == Constants.FIELD_NAME_RESPONSE_MESSAGE_LOG) 
                    {
						Response_Message_Log = parser.getText();
					} 
                    else if (text == Constants.FIELD_NAME_WEB_SERVICE_CLASS) 
                    {
						Web_Service_Class = parser.getText();
					} 
                    else if (text == Constants.FIELD_NAME_WEB_SERVICE_METHOD) 
                    {
						Web_Service_Method = parser.getText();
					} 
                    else if (text == Constants.FIELD_NAME_WEB_SERVICE_NAME) 
                    {
						Web_Service_Name = parser.getText();
					} 
                    else if (text == Constants.FIELD_NAME_REQUEST_SENT) 
                    {
						Request_Sent = DateTime.valueOf(parser.getText());
					} 
                    else if (text == Constants.FIELD_NAME_RESPONSE_RECEIVED) 
                    {
						Response_Received = Datetime.valueOf(parser.getText());
					} 
                    else if (text == Constants.FIELD_NAME_ID) 
                    {
						recordID = parser.getText();
					} 
                    else 
                    {
						System.debug(LoggingLevel.WARN, 'WebServiceLogsRESTParser consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public static WebServiceLogsRESTParser parse(String json) 
    {
        System.JSONParser parser = System.JSON.createParser(json);
        return new WebServiceLogsRESTParser(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) 
    {
		Integer depth = 0;
		do 
        {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) 
            {
				depth++;
			} 
            else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) 
            {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}
}
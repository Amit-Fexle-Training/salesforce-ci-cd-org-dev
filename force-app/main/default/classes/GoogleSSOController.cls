public class GoogleSSOController {
    private static final String CLIENT_ID = '150589326614-b7ofmurc1brppslhu8toe9m4hmngr25e.apps.googleusercontent.com';
    private static final String CLIENT_SECRET = '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';
    private static final String REDIRECT_URI = 'https://godpvtltd3-dev-ed.develop.my.salesforce-sites.com/';
    
    // Method to handle the callback from the Google SSO provider
    @AuraEnabled
    public static void handleCallback() {
        // Retrieve the authorization code from the callback URL
        String authorizationCode = System.currentPageReference().getParameters().get('code');
        
        // Exchange the authorization code for an access token
        String accessToken = exchangeAuthorizationCode(authorizationCode);
        
        // Retrieve the user's email address using the access token
        String email = getUserEmail(accessToken);
        
        // Do something with the email address
        // For example, store it in a custom object or use it to authenticate the user in your system
        System.debug('User email: ' + email);
    }
    
    // Method to exchange the authorization code for an access token
    private static String exchangeAuthorizationCode(String authorizationCode) {
        String tokenEndpoint = 'https://accounts.google.com/o/oauth2/token';
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(tokenEndpoint);
        request.setMethod('POST');
        
        // Set the request body parameters
        String requestBody = 'code=' + EncodingUtil.urlEncode(authorizationCode, 'UTF-8');
        requestBody += '&client_id=' + EncodingUtil.urlEncode(CLIENT_ID, 'UTF-8');
        requestBody += '&client_secret=' + EncodingUtil.urlEncode(CLIENT_SECRET, 'UTF-8');
        requestBody += '&redirect_uri=' + EncodingUtil.urlEncode(REDIRECT_URI, 'UTF-8');
        requestBody += '&grant_type=authorization_code';
        
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setBody(requestBody);
        
        HttpResponse response = new Http().send(request);
        
        if (response.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
            // Return the access token
            return (String) responseMap.get('access_token');
        } else {
            throw new CalloutException('Failed to exchange authorization code for access token. Status code: ' + response.getStatusCode());
        }
    }
    
    // Method to retrieve the user's email address using the access token
    private static String getUserEmail(String accessToken) {
        String userinfoEndpoint = 'https://www.googleapis.com/oauth2/v1/userinfo';
        
        HttpRequest request = new HttpRequest();
        request.setEndpoint(userinfoEndpoint);
        request.setMethod('GET');
        request.setHeader('Authorization', 'Bearer ' + accessToken);
        
        HttpResponse response = new Http().send(request);
        
        if (response.getStatusCode() == 200) {
            Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
            // Return the user's email address
            return (String) responseMap.get('email');
        } else {
            throw new CalloutException('Failed to retrieve user email address. Status code: ' + response.getStatusCode());
        }
    }
}
/*
* Purpose : Class To Send a Mock Response .
* 
* Created By : Amit Kumar
* 
* Created Date : 04/12/2023
* 
* Version : v_0.1 - created 
* 
*/
@isTest
global class ApexSharingHttpCalloutMock implements HttpCalloutMock {
    // Implementing interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Createing a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken"]}');
        response.setStatusCode(Constants.HTTP_CALLOUT_SUCCESS_CODE);
        return response; 
    }
}
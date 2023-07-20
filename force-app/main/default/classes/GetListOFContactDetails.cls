/*
* Purpose : Class With Invocable Method That Will Return A List Of Contact Details.
* 
* Created By : Amit Kumar
* 
* Created Date : 05/11/2023
* 
* Version : v_0.1 - created 
* 
*/
public with sharing class GetListOFContactDetails 
{
    @InvocableMethod(label='Get List Of Contact Details' description='Invocable Method That Will Return A List Of Contact')
    public static List<List<String>> getListOfContactDetails(List<String> contactRecord)
    {
        if(String.isNotBlank(contactRecord[0]))
        {
            List<List<String>> listOfContactDetails = new List<List<String>>();
            List<String> newContactDetails = contactRecord[0].split(',');
            System.debug('newContactDetails : ' + newContactDetails);
            if(newContactDetails.size()==3)
            {
                listOfContactDetails.add(newContactDetails);                
            }
            
            return listOfContactDetails;
        }
           
           return null;
    }
}
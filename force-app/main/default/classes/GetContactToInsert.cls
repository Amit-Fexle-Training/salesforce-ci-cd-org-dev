/*
* Purpose : Class With Invocable Method That Will Return Contact Record.
* 
* Created By : Amit Kumar
* 
* Created Date : 05/11/2023
* 
* Version : v_0.1 - created 
* 
*/
public without sharing class GetContactToInsert 
{
    @InvocableMethod(label='Get Contact To Insert' description='Invocable Method That Will Return A Contact To Insert')
    public static List<Contact> getContactToInsert(List<List<String>> contactDetails)
    {
        if(contactDetails.size()>0)
        {
            List<Contact> listOfContactToInsert = new List<Contact>();
            Contact con = new Contact();
            for(List<String> conDetails : contactDetails)
            {
                for(String fieldDetails : conDetails)
                {
                    List<String> fieldNameAndValues = fieldDetails.split(':');
                    System.debug('fieldNameAndValues : ' + fieldNameAndValues);
                    String filedName = fieldNameAndValues[0];
                    String fieldvalue = fieldNameAndValues[1];
                    
                    
                    if(filedName == 'AssistantName')
                    {
                        con.AssistantName = fieldvalue;
                    }
                    else if(filedName == 'AssistantPhone')
                    {
                        con.AssistantPhone = fieldvalue;
                    }
                    else if(filedName == 'FirstName')
                    {
                        con.FirstName = fieldvalue;
                    }
                    else if(filedName == 'CleanStatus')
                    {
                        con.CleanStatus = fieldvalue;
                    }
                    else if(filedName == 'Jigsaw')
                    {
                        con.Jigsaw = fieldvalue;
                    }
                    else if(filedName == 'Department')
                    {
                        con.Department = fieldvalue;
                    }
                    else if(filedName == 'Description')
                    {
                        con.Description = fieldvalue;
                    }
                    else if(filedName == 'Email')
                    {
                        con.Email = fieldvalue; 
                    }
                    else if(filedName == 'HomePhone')
                    {
                        con.HomePhone = fieldvalue;
                    }
                    else if(filedName == 'IndividualId')
                    {
                        con.IndividualId = fieldvalue;  
                    }
                    else if(filedName == 'LastName')
                    {
                        con.LastName = fieldvalue;
                        System.debug(con.LastName + ' : ' + fieldvalue);
                    }
                    else if(filedName == 'LeadSource')
                    {
                        con.LeadSource = fieldvalue;
                    }
                    else if(filedName == 'MobilePhone')
                    {
                        con.MobilePhone = fieldvalue;
                    }
                    else if(filedName == 'Phone')
                    {
                        con.Phone = fieldvalue;
                    }
                    else if(filedName == 'Title')
                    {
                        con.Title = fieldvalue;
                    }
                }
            }
            listOfContactToInsert.add(con);
            return listOfContactToInsert;
        }
        return null;
    }
}
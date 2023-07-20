/**
*
*  Purpose          :   SOQL Query Wrapper Class.
*
*  Created Date     :   04/24/2023
*
*  Created By       :   Amit Kumar
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class SOQLQueryWrapper 
{
    public String sOQLQuery {get; set;}
    public List<GenericTableHeaderWrapper> listOfGenericTableHeaderWrapper {get; set;}
    
    public SOQLQueryWrapper() 
    {
        sOQLQuery = Constants.CHAR_BLANK;
        listOfGenericTableHeaderWrapper = new List<GenericTableHeaderWrapper>(); 
    }
}
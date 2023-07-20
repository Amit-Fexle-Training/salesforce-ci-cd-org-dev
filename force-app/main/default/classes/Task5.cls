/**
Task :  Write a program that retrieves all the Class records that belong to a specific School 
        and all its related Student using SOQL and displays the names of the Class records 
        and their related Students in the following format: "Class Name: [Class Name], Student Name: [Student Name]"
*
Created By : Amit Kumar
*
Date : 21/03/2023
**/
public class Task5 {
    
    public void allRecords(String schName){
        for(Class__c rec : [Select Name, (Select Name from students__r) from class__c where school__r.Name = :schName]){
            if(rec.students__r.size()>0){
                System.debug(rec.Name + ' : ' +rec.students__r);
            }
        }
        
    }

}
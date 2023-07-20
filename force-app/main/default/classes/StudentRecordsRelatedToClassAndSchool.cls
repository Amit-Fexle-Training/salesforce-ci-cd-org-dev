/*
 * Question 3 : Write an Appex Class to retrieve the Student Records from Class from School.
 * 
 * Created By : Amit Kumar
 * 
 * Created Date : 03/24/2023
*/

public without sharing class StudentRecordsRelatedToClassAndSchool {
    
    //Map to relate Students Rccords with their respective Class Id and School Id
    Map<Id, Map<Id, List<Student__c>>> mapToRelateStudentReccordWithReletedClassIdAndRelatedSchoolId;
    
    //Constructor 
    public StudentRecordsRelatedToClassAndSchool(){
        mapToRelateStudentReccordWithReletedClassIdAndRelatedSchoolId = new Map<Id, Map<Id, List<Student__c>>>();
        
        //Querying Student Reccords With Related Class Id And School Id
        for(Student__c student : [SELECT Name, Id, Student__c.Class__r.Id, Student__c.CLass__r.School__r.Id FROM Student__c]){
            if(mapToRelateStudentReccordWithReletedClassIdAndRelatedSchoolId.containskey(Student.CLass__r.School__r.Id)){
                if(mapToRelateStudentReccordWithReletedClassIdAndRelatedSchoolId.get(Student.CLass__r.School__r.Id).containskey(Student.Class__r.Id)){
                    mapToRelateStudentReccordWithReletedClassIdAndRelatedSchoolId.get(Student.CLass__r.School__r.Id).get(Student.Class__r.Id).add(Student);
                }
                else{
                    mapToRelateStudentReccordWithReletedClassIdAndRelatedSchoolId.get(Student.CLass__r.School__r.Id).put(Student.Class__r.id, new List<Student__c>{Student});
                }
            }
            else {
                Map<Id, List<Student__c>> mapToRelateClassIdWithRespectiveStudentReccord = new Map<Id, List<Student__c>>();
                if(mapToRelateClassIdWithRespectiveStudentReccord.get(Student.Class__r.Id) != null){
                    mapToRelateClassIdWithRespectiveStudentReccord.get(Student.Class__r.Id).add(Student);
                }
                else{
                    mapToRelateClassIdWithRespectiveStudentReccord.put(Student.Class__r.Id, new List<Student__c>{Student});
                }
                mapToRelateStudentReccordWithReletedClassIdAndRelatedSchoolId.put(Student.CLass__r.School__r.Id, mapToRelateClassIdWithRespectiveStudentReccord);
            }
        }
        
        System.Debug(mapToRelateStudentReccordWithReletedClassIdAndRelatedSchoolId);
    }
}
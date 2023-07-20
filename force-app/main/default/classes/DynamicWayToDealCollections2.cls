public class DynamicWayToDealCollections2 {
    Map<String, Map<String, List<Student__c>>> mapToMapSchoolWithAssociatedClassAndStudents;
    public DynamicWayToDealCollections2(){
        mapToMapSchoolWithAssociatedClassAndStudents = new Map<String, Map<String, List<Student__c>>>();
        
        for(Student__c student : [SELECT Name, Student__c.Class__r.Name, Student__c.Class__r.School__r.Name FROM Student__c]){
            if(mapToMapSchoolWithAssociatedClassAndStudents.containskey(Student.Class__r.School__r.Name)){
                if(mapToMapSchoolWithAssociatedClassAndStudents.get(Student.Class__r.School__r.Name).containskey(Student.Class__r.Name)){
                    mapToMapSchoolWithAssociatedClassAndStudents.get(Student.Class__r.School__r.Name).get(Student.Class__r.Name).add(student);
                }
                else{
                    mapToMapSchoolWithAssociatedClassAndStudents.get(Student.Class__r.School__r.Name).put(Student.Class__r.Name, new List<Student__c> {Student});
                }
            }
            else{
                Map<String, List<Student__c>> mapToMapClassAndSchool = new Map<String, List<Student__c>>();
                if(mapToMapClassAndSchool.get(Student.Class__r.Name) == null){
                    mapToMapClassAndSchool.put(Student.Class__r.Name, new List<Student__c>());
                }
                mapToMapClassAndSchool.get(Student.Class__r.Name).add(student);
                mapToMapSchoolWithAssociatedClassAndStudents.put(Student.Class__r.School__r.Name, mapToMapClassAndSchool);
            }
        }
        System.Debug(mapToMapSchoolWithAssociatedClassAndStudents);
    }

}
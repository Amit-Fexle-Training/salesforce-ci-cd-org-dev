/**
Task : You are given two Lists of integers. 
       Write a program that will create a Map where the keys are the elements of the first List, 
       and the values are Sets containing the elements of the second List that are divisible by the key. 
       Once the Map is created, iterate through it and print out the keys and values.

*
Created By : Amit Kumar
*
Date : 20/03/2023
**/
public class Task4 {
    
    Map<Integer, Set<Integer>> MyMap = new Map<Integer, Set<Integer>>();
   
    public void FinalMap(List<Integer> L1, List<Integer> L2){
        
        For(Integer i : L1){
            Set<Integer> myList = new Set<Integer>();
            For(Integer j : L2){
                If(math.mod(j, i) == 0){
                    myList.Add(j);
                } 
            }
            MyMap.put(i, myList);
        }
        
        for(Integer i : MyMap.keySet()){
            System.debug(i + ' =>' + MyMap.get(i));
        }
    }

}
/**
List<Integer> list1 = new List<integer>{2,3,4};
List<Integer> list2 = new List<integer>{4,6,8,9,12};    
Task4 t1 = new Task4();
t1.FinalMap(list1, list2);
**/
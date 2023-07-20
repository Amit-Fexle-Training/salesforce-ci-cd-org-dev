/**
Task : Create a Map that maps a string key to an integer value.
       Add five key-value pairs to the map.
       Write a method that takes the Map as a parameter and returns the sum of all the values in the map.
*
Created By : Amit Kumar
*
Date : 16/03/2023
**/

public class Task3 {
    public void AllCollections(List<Integer> myList){
        List<Integer> L = new List<Integer>();
        L.AddAll(myList);
        
        Set<Integer> S = new Set<Integer>();
        S.AddAll(myList);
        
        Map<Integer, Integer> M = new Map<Integer, Integer>();
        For(Integer i=1; i<=myList.size(); i++){
            M.put(myList[i-1], myList[i-1]);
        }
        
        System.debug('List : ' + L);
        System.debug('Set : ' + S);
        System.debug('Map : ' + M);
        
        for( Integer A : S){
            
            System.debug(A);
        }
        
    }
}

/**
List<Integer> list1 = new List<integer>{1,2,6,4,5};
Task3 t1 = new Task3();
t1.AllCollections(list1);
**/
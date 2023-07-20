/**
Task : Create a Map that maps a string key to an integer value.
       Add five key-value pairs to the map.
       Write a method that takes the Map as a parameter and returns the sum of all the values in the map.
*
Created By : Amit Kumar
*
Date : 16/03/2023
**/

public class Task2 {    
    
    //Method that takes the Map as a parameter and returns the sum of all the values in the map
    public Integer FindSum(Map<String, Integer> mymap){
        Integer sum =0;
        for(Integer M : mymap.values() ){
            sum+= M;
        } 
        return sum;
    }

}
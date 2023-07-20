/**
 * 
 * Purpose           : Class to Demostrate Shoping Cart where User can add Items to cart and can View the Items of Cart.
 * 
 * Created Date      :     03/15/2023
 * 
 * Created By        :     Amit Kumar
 * 
 * Revision Logs     :     V_1.0 - Created
 * 
**/
public without sharing class ShoppingCart3 {
    List<Cart__c> ShopingCart = new List<Cart__c>();
    
    Cart__c Item1 = new Cart__c(Item_Name__c ='Potato', Price__c = 35.68, Quantity__c= 20);
    Cart__c Item2 = new Cart__c(Item_Name__c ='Tomato', Price__c = 45.78, Quantity__c= 40);
    Cart__c Item3 = new Cart__c(Item_Name__c ='Sugar', Price__c = 145.37, Quantity__c= 5);
    

}
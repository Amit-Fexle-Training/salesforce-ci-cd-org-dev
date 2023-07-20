/*
*
* Purpose : My First LWC Component
*
*Created Date : 05/19/2023
*
* Created By : Amit Kumar
*
* Revision Log : v_1.0 - created - 05/19/2023
*
*/
import { LightningElement, api } from 'lwc';
export default class MyFirstComponent extends LightningElement 
{
    @api myObjectName = 'Account';
    localObjectName='';

    connectedCallback() 
    {
        this.localObjectName = 'Good To See You ' + this.myObjectName + ' Yep!!!!';
    }
}
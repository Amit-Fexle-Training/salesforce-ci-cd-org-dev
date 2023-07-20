/*
Purpose         :   Utilities JS
Created By      :   Amit  Kumar
Created Date    :   06/01/2023
Current Version :   v1.0
Revision Log    :   V_1.0 Created - Amit Kumar - 06/01/2023
*/
import { LightningElement } from 'lwc';

//Import Toast message
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

//Import Alert message
import LightningAlert from 'lightning/alert'; 

//Import Confirm message
import LightningConfirm from 'lightning/confirm';

//Import Prompt message
import LightningPrompt from 'lightning/prompt';

//Importing Pagereference Navigation
import { NavigationMixin } from 'lightning/navigation';

//Importing Constants
import {PAGEREFERENCE_TYPES, STATUS_MESSAGES} from 'c/constants';

const ERROR_MESSAGE_I_AM_KIDDING = 'I am kidding !!';

//Default Export of a class/function/property
export default class Utilities extends NavigationMixin(LightningElement) 
{
    //https://sfwiseguys.wordpress.com/2020/11/15/lwc-navigation/#:~:text=A%20PageReference%20is%20a%20JavaScript,can%20use%20different%20URL%20formats.
    // Navigate to an External URL (Wikipedia in our case)
    static navigateToWebPage(urlPrefix, searchString, component) 
    {
        if(!Object.is(searchString, null) && !Object.is(urlPrefix, null)) 
        {
            component[NavigationMixin.Navigate](
            {
                type: PAGEREFERENCE_TYPES.PAGEREFERENCE_TYPE_NAVIGATE_TO_WEB_PAGE,
                attributes: 
                {
                    url: urlPrefix + searchString
                }
            });
        }
        else
        {
            showToastMessage(STATUS_MESSAGES.ERROR_LOWERCASE , ERROR_MESSAGE_I_AM_KIDDING, STATUS_MESSAGES.ERROR_LOWERCASE);
        }
    }
}

//Class
class EventUtilities {}

//https://codeburst.io/javascript-object-oriented-programming-using-es6-3cd2ac7fbbd8
//https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Objects/Classes_in_JavaScript
//https://huzaifaahmed.com/oop-in-js
//Inheritance and exporting a class
class CustomEventsUtilities extends EventUtilities 
{
    //Method
    fireCustomEvent(customEventName, details, component) 
    {
        const selectedEvent = new CustomEvent(customEventName, 
        {
            detail: details
        })
        component.dispatchEvent(selectedEvent);
    }
}

class NotificationsUtilities 
{
    static showToastMessageNotification(strTitle, strMsg, strType)
    {
        const successToast = new ShowToastEvent(
        {
            title : strTitle,
            message : strMsg,
            variant : strType
        });
        dispatchEvent(successToast);
    }

    static showAlertMessageNotification()
    {
        LightningAlert.open(
        {
            message: 'This is the alert message.',
            theme: 'error', // a red theme intended for error states
            label: 'Error!', // this is the header text
        });
        // alert modal has been closed
    }

    static showPromptMessageNotification()
    {
        LightningPrompt.open(
        {
            message: 'This is the prompt message.',
            //theme defaults to "default"
            label: 'Please Respond!', // this is the header text
            defaultValue: 'Enter a message',
        })
        .then(() => 
        {
            // prompt modal has been closed
        });
    }

    static showConfirmMessageNotification()
    {
        LightningConfirm.open(
        {
            message: 'I am kidding guys',
            variant: 'headerless',
            label: 'This is the aria-label value',
            // label value isn't visible in the headerless variant
        });
        // confirm modal has been closed
    }
}

export {CustomEventsUtilities, NotificationsUtilities};
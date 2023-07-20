/*
*Purpose : LWC component to create student
*
*Created Date : 05/23/2023
*
* Created By : Amit Kumar
*
* Revision Log : v_1.0 - created - 05/23/2023
*
*/
import { LightningElement, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { CloseActionScreenEvent } from 'lightning/actions'

export default class CreateStudentComponent extends LightningElement 
{
    @api recordId;

    handleSuccess(event) {
        // Close the modal window and display a success toast
        this.dispatchEvent(new CloseActionScreenEvent());
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Student Record With Id : ' + event.detail.id + ' Is Created!',
                variant: 'success'
            })
        );
   }
}
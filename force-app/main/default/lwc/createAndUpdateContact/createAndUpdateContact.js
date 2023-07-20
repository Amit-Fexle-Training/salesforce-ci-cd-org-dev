import { LightningElement, api} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { RefreshEvent } from 'lightning/refresh';

import CONTACT_OBJECT from '@salesforce/schema/Contact'
export default class CreateAndUpdateContact extends LightningElement {

    @api recordId;
    objectApiName = CONTACT_OBJECT;

    firstName = '';
    lastName = '';
    email = '';

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Contact Created',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.dispatchEvent(new RefreshEvent());
    }

}
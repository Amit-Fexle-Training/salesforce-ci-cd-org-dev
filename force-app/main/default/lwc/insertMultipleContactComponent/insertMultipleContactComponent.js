import { LightningElement, track} from 'lwc';

import addContactRecords from '@salesforce/apex/InsertMultipleContactComponentController.addRecord';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columnsData = [
    { label: 'LastName', fieldName: 'LastName' },
    { label: 'FirstName', fieldName: 'FirstName' },
    { label: 'Email', fieldName: 'Email' },
];

export default class InsertMultipleContactComponent extends LightningElement 
{
    @track contactList = [];
    @track errorMessage='';
    @track message='';
    @track columns = columnsData;
    @track contactCreated=false;
    rowNumber=1;

    handleAdd()
    {
        const key = Date.now().toString();
        this.contactList.push({
            key: key,
            rowNumber: this.rowNumber++,
            lastName: '',
            firstName: '',
            email: ''
        });
        this.reorderRowNumbers();
    }

     handleLastNameChange(event) 
     {
        const index = event.target.dataset.index;
        this.contactList[index].LastName = event.target.value;
    }

    handleFirstNameChange(event) 
    {
        const index = event.target.dataset.index;
        this.contactList[index].FirstName = event.target.value;
    }

    handleEmailChange(event) 
    {
        const index = event.target.dataset.index;
        this.contactList[index].Email = event.target.value;
    }

    handleDelete(event) 
    {
        const index = event.target.dataset.index;
        this.contactList.splice(index, 1);
        this.reorderRowNumbers();
    }

    reorderRowNumbers() 
    {
        this.contactList.forEach((contact, index) => {
            contact.rowNumber = index + 1;
        });
    }

    handleSave() 
    {
        this.contactCreated=false;
        addContactRecords
        (
            {
                contactList : this.contactList,
            }
        )
        .then((result) => 
        {
            if(result.isSuccess)
            {
                this.message = result.message;
                this.dispatchEvent(
                    new ShowToastEvent({
                title: 'Success',
                message: this.message,
                variant: 'Success'
                    })
                );
                this.contactCreated=true;
            }
            else
            {
                this.errorMessage = result.msg;
                this.dispatchEvent(
                    new ShowToastEvent({
                title: 'Error',
                message: this.errorMessage,
                variant: 'error'
                    })
                );
            }
        })
        .catch((error) => 
        {
            console.log('@@@@ '+ JSON.stringify(error));
        })
        .finally(() =>
        {
            this.clearErrorMessage();
            console.log('I Am Inside handleSave Method');
        });
    }

    clearErrorMessage() 
    {
        this.errorMessage = '';
    }
}
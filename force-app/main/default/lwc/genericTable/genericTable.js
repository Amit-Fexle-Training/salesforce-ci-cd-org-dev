/*
*
* Purpose : Generic Table To Display Different Object Records Using Standard LWC Table Component
*
*Created Date : 05/19/2023
*
* Created By : Amit Kumar
*
* Revision Log : v_1.0 - created - 05/19/2023
*
*/
import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//Importing Apex Class
import doRecordsQuery from '@salesforce/apex/GenericTableController.doQuery';

//Importing Constants
import { CHARACTERS, NUMBERS } from 'c/constants';

const columnsData = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'Name', fieldName: 'Name' },
    { label: 'Website', fieldName: 'Website' },
];

export default class GenericTable extends LightningElement 
{
    //Public Properties
    @api objectName = CHARACTERS.CHAR_BLANK;
    @api fieldsName = CHARACTERS.CHAR_BLANK;
    @api limitValue = NUMBERS.NUMBER_FIVE;

    @track data = [];
    @track columns = columnsData;
    @track isLoading = true;
    @track errorMessage = CHARACTERS.CHAR_BLANK;
    
    /*
    connectedCallback() 
    {
        console.log('@@@@ objectName : ' + this.objectName);
        console.log('@@@@ fieldsName : ' + this.fieldsName);
        console.log('@@@@ limitValue : ' + this.limitValue);
        console.log('@@@@ CHARACTERS : ' + JSON.stringify(CHARACTERS));
        console.log('@@@@ NUMBERS : ' + JSON.stringify(NUMBERS));
    }
    */
    connectedCallback() {
        this.handleSearch();
    }

    handleSearch() {
        this.isLoading = true;
        doRecordsQuery
        (
            { 
                objectName: this.objectName,
                fieldsName: this.fieldsName,
                limitValue: this.limitValue
            }
        )
        .then((result) => 
        {
            this.data = result;
            if(result.isSuccess)
            {
                this.data = result.body;
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
            this.isLoading = false;
            this.clearErrorMessage();
            console.log('I Am Kidding Inside Final Method');
        });
    }

    clearErrorMessage() 
    {
        this.errorMessage = '';
    }
}
/*
*
* Purpose : List Of Contacts Relayed To Account In Tabular Form Component
*
*Created Date : 05/19/2023
*
* Created By : Amit Kumar
*
* Revision Log : v_1.0 - created - 05/19/2023
*
*/
import { LightningElement, api, track } from 'lwc';
import { registerRefreshContainer, unregisterRefreshContainer, REFRESH_ERROR, REFRESH_COMPLETE, REFRESH_COMPLETE_WITH_ERRORS } from 'lightning/refresh';

//Importing Constants
import { CHARACTERS } from 'c/constants';

const columnsData = [
    { label: 'Id', fieldName: 'Id' },
    { label: 'First Name', fieldName: 'FirstName' },
    { label: 'Last Name', fieldName: 'LastName' },
];

//Importing Apex Class
import doRecordsQuery from '@salesforce/apex/ListOfContactsRelatedToAccountController.doQuery';

export default class ListOfContactsRelatedToAccount extends LightningElement {
    //Public Properties
    @api recordId = CHARACTERS.CHAR_BLANK;

    @track data = [];
    @track columns = columnsData;
    @track isLoading = true;


    refreshContainerID;

    connectedCallback() {
        this.handleSearch();
        this.refreshContainerID = registerRefreshContainer(this, this.refreshContainer);
    }


    disconnectedCallback() {
        unregisterRefreshContainer(this.refreshContainerID);
    }
    refreshContainer(refreshPromise) {
        console.log('refreshing');
        return refreshPromise.then((status) => {
            if (status === REFRESH_COMPLETE) {
                console.log('Done!');
                this.handleSearch();
            }
            else if (status === REFRESH_COMPLETE_WITH_ERRORS) {
               console.warn('Done, with issues refreshing some components');
            }
            else if (status === REFRESH_ERROR) {
               console.error('Major error with refresh.');
            }
         });
    }

    handleSearch() {
        this.isLoading = true;

        doRecordsQuery({
            recordId: this.recordId,
        })
            .then((result) => {
                this.data = result;
            })
            .catch((error) => {
                console.log('@@@@ ' + JSON.stringify(error));
            })
            .finally(() => {
                this.isLoading = false; 
                console.log('I Am Kidding Inside Final Method');
            });
    }
}
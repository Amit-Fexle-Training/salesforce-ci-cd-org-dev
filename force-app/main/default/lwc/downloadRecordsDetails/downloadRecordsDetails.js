/*
*
*Purpose : LWC component to Download Related Contacts Of Account
*
*Created Date : 06/03/2023
*
* Created By : Amit Kumar
*
* Revision Log : v_1.0 - created - 06/03/2023
*
*/
import { LightningElement, api, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


//Importing Apex Classes
import getRecords from '@salesforce/apex/DownloadRecordsDetailsController.getRecord';

export default class DownloadRecordsDetails extends LightningElement 
{
    @api recordId;
    @api flexipageRegionWidth;

    @track listOfContacts=[];
    
    //State variable to control rendering the HTML markup
    @track state =
    {
        initDone : false
    }

    connectedCallback() 
    {
        this.state.initDone = true;
    }

    downloadRecord()
    {
        console.log('#### recordId : ' + this.recordId);
        getRecords
        (
            {
                accountId : this.recordId
            }
        )
        .then((result) => 
        {
            if(result.isSuccess)
            {
                this.listOfContacts = result.body;
                this.downloadContacts();
            }
            else
            {
                this.dispatchEvent(
                    new ShowToastEvent({
                title: 'Error',
                message: result.msg,
                variant: 'error'
                    })
                );
            }
        })
        .catch((error) => 
        {
            console.error('Error fetching records:', JSON.parse(error));
        })
        .finally(() =>
        {
            console.log('@@@ listOfContacts : ' + this.listOfContacts.length + ' --- --- ' + this.listOfContacts + ' RecordId : ' + this.recordId);
        });
    }

    downloadContacts() {
    // Create a CSV content from the listOfContacts data
    let csvContent = 'data:text/csv;charset=utf-8,';
    csvContent += 'FirstName,LastName,Email,Phone\n'; // Add headers

    // Iterate over the contact records and append their data to the CSV content
    this.listOfContacts.forEach((contact) => {
        csvContent += `${contact.FirstName},${contact.LastName},${contact.Email},${contact.Phone}\n`;
    });

    // Create a data URI for the CSV content
    const encodedUri = encodeURI(csvContent);

    // Create a temporary anchor element to initiate the download
    const link = document.createElement('a');
    link.setAttribute('href', encodedUri);
    link.setAttribute('download', 'contacts.csv');

    // Simulate a click on the anchor element to start the download
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
}


    handleDownload()
    {
        this.downloadRecord();
    }
}
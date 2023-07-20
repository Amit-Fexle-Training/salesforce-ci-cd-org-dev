/*
*
* Purpose : Component To Take Object Name From User and Show All Records Of Object On UI
*
*Created Date : 05/22/2023
*
* Created By : Amit Kumar
*
* Revision Log : v_1.0 - created - 05/19/2023
*
*/
import { LightningElement, api, track} from 'lwc';

//Importing Apex Class
import getRecordDetails from '@salesforce/apex/ObjectRecordDetailsController.getRecordDetail';

export default class ObjectRecordDetails extends LightningElement 
{
    @api recordId;
    @api objectName;
    @track selectedRecord = [];

    connectedCallback() 
    {
        this.loadRecordDetails();
    }

    // Setter for recordId
    @api
    setRecordId(recordId) {
        this.recordId = recordId;
        this.loadRecordDetails();
    }

    // Setter for objectName
    @api
    setObjectName(ObjectName) {
        this.objectName = ObjectName;
    }

    loadRecordDetails()
    {
        getRecordDetails
        (
            {
                recordId: this.recordId,
                objectName: this.objectName,
            }
        )
        .then((result) => 
        {
            this.selectedRecord = result;
        })
        .catch((error) => 
        {
            console.error('Error retrieving records:', error);
        })
        .finally(() =>
        {
            console.log('I Am Kidding Inside Final Method');
        });
    }
}
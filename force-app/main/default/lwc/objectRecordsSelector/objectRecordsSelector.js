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
import { LightningElement, track } from 'lwc';

//Importing Apex Class
import getObjectRecords from '@salesforce/apex/ObjectRecordsSelectorController.getRecords';

export default class ObjectRecordsSelector extends LightningElement 
{
    //Public Properties
    @track objectName;
    @track recordOptions;
    @track selectedRecordId;

    handleGetRecords()
    {
        getObjectRecords
        (
            { 
                objectName: this.objectName,
            }
        )
        .then((result) => {
            this.recordOptions = result.map((record) => ({
            label: record.Name,
            value: record.Id
            }));
        })
        .catch((error) => {
            console.error('Error retrieving records:', error);
        })
        .finally(() =>
        {
            console.log('I Am Kidding Inside Final Method');
        });
    }

    handleObjectNameChange(event) 
    {
        this.objectName = event.target.value;
    }

    handleRecordSelected(event) 
    {
        this.selectedRecordId = event.target.value;
        this.dispatchEvent(
            new CustomEvent('objectselected', 
            {
                detail: { recordId: this.selectedRecordId,
                        objectName: this.objectName }
            })
        );
    }
}
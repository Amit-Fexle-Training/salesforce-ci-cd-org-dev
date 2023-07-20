/*
*
* Purpose : This Component will display report of all the records queried by applying filter on the selected obj
*
*Created Date : 05/27/2023
*
* Created By : Amit Kumar
*
* Revision Log : v_1.0 - created - 05/27/2023
*
*/
import { LightningElement,api, track} from 'lwc';
//Importing Apex Class
import getObjectsList from '@salesforce/apex/ReportDisplayComponentController.getObject';
import getFieldsList from '@salesforce/apex/ReportDisplayComponentController.getField';

//Importing Constants
import { CHARACTERS, NUMBERS } from 'c/constants';

export default class ReportDisplayComponent extends LightningElement 
{
    @track objectOptions = []; //array to hold all objects
    @track selectedObject = CHARACTERS.CHAR_BLANK; //variable to hold slected object name
    @api fieldOptions = [];
    @track selectedFields = CHARACTERS.CHAR_BLANK;

    connectedCallback() 
    {
        this.getAllObject();
    }
    //Method to get All Object
    getAllObject()
    {
        getObjectsList
        (
            {
                
            }
        )
        .then((result) =>
        {
            if(result.isSuccess)
            {
                //Creating map 
                this.objectOptions = result.getList.map(option =>
                ({ label: option, value: option })
                );
            }
            else
            {
                this.errorMessage = result.msg;
            }
        }
        )
        .catch((error) => 
        {
            console.log('@@@@ '+ JSON.stringify(error));
        })
        .finally(() =>
        {
            this.isLoading = false;
            console.log('handleObjectChange runs Successfully' + this.objectOptions + '@@@ selectedObject : ' + this.selectedObject);
        });
    }

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
        //Seting fieldOptions arry to null when object is changed
        this.fieldOptions = [];
        this.selectedFields = CHARACTERS.CHAR_BLANK;
        //calling loadFields method to get list of fields of selected object
        this.loadFields();
    }

    loadFields()
    {
        console.log('@@@ selectedObject : ' + this.selectedObject);
        getFieldsList
        (
            {
                selectedObjectname : this.selectedObject,
            }
        )
        .then((result) =>
        {
            if(result.isSuccess)
            {
                //Creating map 
                this.fieldOptions = result.getList.map(option =>
                ({ label: option, value: option })
                );
            }
            else
            {
                this.errorMessage = result.msg;
            }
        }
        )
        .catch((error) => 
        {
            console.log('@@@@ '+ JSON.stringify(error));
        })
        .finally(() =>
        {
            this.isLoading = false;
            console.log('loadFields runs Successfully' + this.fieldOptions);
        });
    }

    handleFieldChange(event) {
        const newSelection = event.detail.value;
        const previouslySelectedFields = [...this.selectedFields];

        // Find the fields that have been deselected
        const deselectedFields = previouslySelectedFields.filter(
            (field) => !newSelection.includes(field)
        );

        // Remove the deselected fields from the selectedFields array
        this.selectedFields = newSelection.filter(
            (field) => !deselectedFields.includes(field)
        );

        console.log('previouslySelectedFields : ' + previouslySelectedFields + ' Selected Fields: ' + this.selectedFields);
    }
}
import { LightningElement, api, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { CHARACTERS} from 'c/constants';

import deleteCurrentRecord from '@salesforce/apex/SchoolDetailsController.deleteRecord';
import deleteBulkRecord from '@salesforce/apex/SchoolDetailsController.deleteBulk';
import updateBulkRecord from '@salesforce/apex/SchoolDetailsController.updateBulk';

export default class ShowTableComponent extends LightningElement 
{
    @api studentData = [];
    @track isLoading = true;
    @track isLoadingDelete = false;
    @track isLoadingEdit = false;
    @track isLoadingBulkDelete =false;
    @track updateButtonClicked = false;
    @track errorMessage = CHARACTERS.CHAR_BLANK;
    @track selectedValues = [];
    @track name = CHARACTERS.CHAR_BLANK;
    @track type = CHARACTERS.CHAR_BLANK;
    @track fatherName = CHARACTERS.CHAR_BLANK;
    @track fatherEmail = CHARACTERS.CHAR_BLANK;

    handleSearch() 
    {
        this.isLoading = true;
        doRecordsQuery
        (
            { 
                recordId: recordId,
            }
        )
        .then((result) => 
        {
            if(result.isSuccess)
            {
                this.classList = result.body;
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

    handleNameChange(event) {
        this.name = event.target.value;
    }

    handleTypeChange(event) {
        this.type = event.target.value;
    }

    handleFatherNameChange(event) {
        this.fatherName = event.target.value;
    }

    handleFatherEmailChange(event) {
        this.fatherEmail = event.target.value;
    }

    handleCheckboxChange(event) 
    {
        // Get the checkbox value
        const isChecked = event.target.checked;
        const value = event.target.value;

        // Perform actions based on the checkbox state
        if (isChecked) 
        {
            // Checkbox is checked, perform some logic
            this.selectedValues.push(value);
        } 
        else 
        {
            // Checkbox is unchecked, perform some other logic
            const index = this.selectedValues.indexOf(value);
            if (index !== -1) 
            {
                this.selectedValues.splice(index, 1);
            }
        }
    }

    handleUpdateSubmit()
    {
        this.isLoadingEdit = true;
        updateBulkRecord
        (
            { 
                studentIdList : this.selectedValues,
                name : this.name,
                type : this.type,
                fatherName : this.fatherName,
                fatherEmail : this.fatherEmail,
            }
        )
        .then((result) => 
        {
            if(result.isSuccess===false)
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
            console.log('@@@ Student Record Is Updated');
        })
        .catch((error) => 
        {
            console.log('@@@@ '+ JSON.stringify(error));
        })
        .finally(() =>
        {
            this.isLoadingEdit = false;
            this.clearErrorMessage();
            console.log('I Am Kidding Inside Final Method');
        });
    }

    handleDeleteAll() 
    {
        this.isLoadingBulkDelete = true;
        // Perform deletion logic for all selected values
        deleteBulkRecord
        (
            {
                studentIdList: this.selectedValues,
            }
        )
        .then((result) => 
        {
            if(result.isSuccess===false)
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
            console.log('@@@ Student Record Is deleted');
        })
        .catch((error) => 
        {
            console.log('@@@@ '+ JSON.stringify(error));
        })
        .finally(() =>
        {
            this.isLoadingBulkDelete = false;
            this.clearErrorMessage();
            console.log('I Am Kidding Inside Final Method');
        });
        
        // Reset selectedValues array
        this.selectedValues = [];
    }

    handleEditAll()
    {
        // Perform deletion logic for all selected values
        this.updateButtonClicked = true;
    }

    handleCloseSubmit()
    {
        this.updateButtonClicked = false;
    }

    handleDelete(event)
    {
        this.isLoadingDelete = true;
        const studentId = event.target.dataset.studentid;
        deleteCurrentRecord
        (
            {
                studentId: studentId,
            }
        )
        .then((result) => 
        {
            if(result.isSuccess===false)
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
            console.log('@@@ Student Record Is deleted');
        })
        .catch((error) => 
        {
            console.log('@@@@ '+ JSON.stringify(error));
        })
        .finally(() =>
        {
            this.isLoadingDelete = false;
            this.clearErrorMessage();
            console.log('I Am Kidding Inside Final Method');
        });
    }

    handleDelete(event)
    {
        this.isLoadingDelete = true;
        const studentId = event.target.dataset.studentid;
        deleteCurrentRecord
        (
            {
                studentId: studentId,
            }
        )
        .then((result) => 
        {
            if(result.isSuccess===false)
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
            console.log('@@@ Student Record Is deleted');
        })
        .catch((error) => 
        {
            console.log('@@@@ '+ JSON.stringify(error));
        })
        .finally(() =>
        {
            this.isLoadingDelete = false;
            this.clearErrorMessage();
            console.log('I Am Kidding Inside Final Method');
        });
    }

    clearErrorMessage() 
    {
        this.errorMessage = '';
    }
}
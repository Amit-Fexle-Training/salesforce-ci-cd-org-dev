/*
*
* Purpose : Child Component To Show Filtered Record
*
*Created Date : 05/27/2023
*
* Created By : Amit Kumar
*
* Revision Log : v_1.0 - created - 05/27/2023
*
*/
import { LightningElement, api, track} from 'lwc';

import getRecordsList from '@salesforce/apex/ReportDisplayComponentController.getRecord';

export default class ShowRecordTable extends LightningElement 
{
    @track recordList = [];
    @track tableHeaders;

    connectedCallback() 
    {
        this.fetchRecords();
        if (this.recordList && this.recordList.length > 0) 
        {
            this.tableHeaders = Object.keys(this.recordList[0]);
        }
    }

    get tableData() 
    {
        if (!this.recordList || this.recordList.length === 0) 
        {
            return [];
        }

        return this.recordList.map((record) => 
        {
            return this.tableHeaders.map((header) => record[header]);
        });
    }

    fetchRecords()
    {
        getRecordsList
        (
            {
                
            }
        )
        .then((result) =>
        {
            if(result.isSuccess)
            {
                this.recordList = result.recordList;
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
            console.log('### fetchRecords runs Successfully' + this.recordList);
        });
    }
}
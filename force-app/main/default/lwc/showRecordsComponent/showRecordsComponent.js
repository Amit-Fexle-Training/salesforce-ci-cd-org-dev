import { LightningElement, track, api } from 'lwc';
import getRecordsByObjectName from '@salesforce/apex/ShowRecordsComponentController.getRecords';

const MAX_RECENT_RECORDS = 5;

export default class ShowRecordsComponent extends LightningElement 
{
  @api objectName = '';
  @track selectedRecordId = null;
  @track recordOptions = [];
  @track filteredRecords = [];

  handleComboBoxFocus() {
    if (this.recordOptions.length === 0) {
      // Retrieve records from Apex class based on the objectName
      getRecordsByObjectName({ objectName: this.objectName })
        .then(result => {
          // Process the retrieved records and update the recordOptions array
          this.recordOptions = result.recordList.map(record => ({
            label: record.Name,
            value: record.Id,
            group: 'All Records'
          }));

          console.log('@@@ recordOptions : ' + this.recordOptions);

          // Show only the five most recent records initially
          this.filteredRecords = this.recordOptions.slice(0, MAX_RECENT_RECORDS);
          console.log('@@@ filteredRecords : ' + this.filteredRecords);
        })
        .catch(error => {
          console.error('Error retrieving records:', error);
        });
    }
  }

  handleRecordSelection(event) {
    this.selectedRecordId = event.detail.value;
    // Fire event to the parent component with the selected record's ID and name
    const selectedRecord = this.recordOptions.find(record => record.value === this.selectedRecordId);
    if (selectedRecord) {
      const recordId = selectedRecord.value;
      const recordName = selectedRecord.label;
      this.dispatchEvent(new CustomEvent('recordselect', { detail: { recordId, recordName } }));
    }
  }

  handleRecordNameChange(event) {
    const searchValue = event.target.value.toLowerCase();
    if (searchValue) {
      this.filteredRecords = this.recordOptions.filter(record => record.label.toLowerCase().includes(searchValue));
    } else {
      this.filteredRecords = this.recordOptions.slice(0, MAX_RECENT_RECORDS);
    }
  }
}
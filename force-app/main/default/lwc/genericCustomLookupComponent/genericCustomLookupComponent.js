import { LightningElement, track } from 'lwc';
export default class GenericCustomLookupComponent extends LightningElement 
{
    @track objectName = '';

    handleObjectNameChange(event) {
        this.objectName = event.target.value;
        console.log('@@@ objectName : ' + objectName);
    }

    handleRecordSelect(event) {
        const recordId = event.detail.recordId;
        const recordName = event.detail.recordName;
        console.log('Selected Record ID:', recordId);
        console.log('Selected Record Name:', recordName);
    }
}
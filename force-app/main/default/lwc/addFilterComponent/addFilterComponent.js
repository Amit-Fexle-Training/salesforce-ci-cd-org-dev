/*
*
* Purpose : Child Component For reportDisplayComponent to add filter for querying records
*
*Created Date : 05/27/2023
*
* Created By : Amit Kumar
*
* Revision Log : v_1.0 - created - 05/27/2023
*
*/
import { LightningElement, api, track } from 'lwc';
export default class AddFilterComponent extends LightningElement 
{
    @api fieldOptions;
    @track comboRows = [];
    @track operatorOptions = ['AND', 'OR', 'Custom']; 
    @track disableDeleteFilterButton;
    @track selectedRule;
    @track RuleOptions = [
        { label: 'AND', value: 'AND' },
        { label: 'OR', value: 'OR' },
        { label: 'Custom Logic', value: 'CustomLogic' }
    ];
    @track filterLogic;
    @track custom;

    handleFieldChange(event) 
    {
      const index = event.target.dataset.index;
      this.comboRows[index].fieldName = event.target.value;
    }

    handleOperatorChange(event) 
    {
      const index = event.target.dataset.index;
      this.comboRows[index].operator = event.target.value;
    }

    handleValuesChange(event) 
    {
      const index = event.target.dataset.index;
      this.comboRows[index].values = event.target.value;
    }

    handleRuleChange(event)
    {
      this.selectedRule = event.target.value;
      if(this.selectedRule == 'CustomLogic')
      {
        this.custom = true;
      }
      else
      {
        this.custom = false;
      }
      console.log('@@@ selectedRule : ' + this.selectedRule + '@@@ custom : ' + this.custom);
    }

    handleFilterLogic(event)
    {
      this.filterLogic = event.target.value;
      console.log('@@@ filterLogic : ' + this.filterLogic);
    }

    handleAddFilter() {
    if (this.comboRows.length < 5) {
      const newComboRow = {
        id: Date.now(),
        fieldName: '',
        operator: '',
        values: ''
      };
      this.comboRows.push(newComboRow);
      console.log('@@@@ fieldOptions :-> ' + this.fieldOptions);
    }
  }

  handleDeleteFilter() 
  {
    if (this.comboRows.length > 1) 
    {
      this.comboRows.pop();
    }
  }
}
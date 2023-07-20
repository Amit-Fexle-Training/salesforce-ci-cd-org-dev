/*
*
*  Purpose          :	LWC component to display Data Grid - Content - JS file.
*
*  Created Date     :  	06/01/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 Created - Amit Kumar - 06/01/2023
*
*/
import { LightningElement, api, track } from 'lwc';

export default class DataGridContent extends LightningElement 
{
    //Public Properties
    @api flexipageRegionWidth;
    @api objectName;
    @api fieldsName;
    @api limitValue;
    
    //State variable to control rendering the HTML markup
    @track state =
    {
        initDone : false
    }

    connectedCallback() 
    {
        this.state.initDone = true;
    }
}
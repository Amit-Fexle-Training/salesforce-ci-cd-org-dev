/*
*
*  Purpose          :	Tile (Lightning Web Component) JS
*
*  Created Date     :  	12/13/2022
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 - Created - 06/02/2023
*
*/
import { LightningElement, wire, track } from 'lwc';

import { registerListener } from 'c/pubsub';
import { CurrentPageReference } from 'lightning/navigation';

//Importing Custom Events
import {CUSTOM_EVENTS} from 'c/customEvents';

const SELECTED_ROW_NUMBER = 'Selected Row Number # ';

export default class Tiles extends LightningElement 
{
    @wire(CurrentPageReference) pageRef;

    //State variable to control rendering the HTML markup
    @track state =
    {
        initDone : false,
        rowsExistsToDisplay : false
    }

    @track rows = [];
    selectedRowNumbers;
    
    connectedCallback() 
    {
        this.state.rowsExistsToDisplay = false;
        this.state.initDone = false;
        
       /* param1: name of event we fired
          param2: The Method that will be called when the event is received
          param3: A reference to this component
       */
       registerListener(CUSTOM_EVENTS.CUSTOM_EVENT_SELECTED_ROW_DETAILS_FOR_TILES, this.handleSiblingEvent, this);

       this.state.initDone = true;
   }

   handleSiblingEvent(siblingData)
   {
       this.rows = [];
       if(siblingData)
       {
           if(siblingData.rows)
           {
               this.rows = siblingData.rows;
           }

           if(siblingData.selectedRowNumbers)
           {
               this.selectedRowNumbers = SELECTED_ROW_NUMBER + siblingData.selectedRowNumbers;
           }
        }

        if(!Object.is(this.rows, null) && this.rows.length > 0) 
        {
            this.state.rowsExistsToDisplay = true;
        }
        else 
        {
            this.state.rowsExistsToDisplay = false;
        }
    }
}
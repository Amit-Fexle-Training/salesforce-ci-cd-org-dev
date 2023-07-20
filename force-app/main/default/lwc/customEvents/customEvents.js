/*
*
*  Purpose          :	Generic Table to display different object records using standard LWC table component JS.
*
*  Created Date     :  	06/01/2023
*
*  Created By       :  	Amit Kumar
*
*  Revision Logs    :  	V_1.0 Created - Amit Kumar - 06/01/2023
*
*/
const CUSTOM_EVENT_SELECTED_ROW_DETAILS = 'selectedrowsdetails';
const CUSTOM_EVENT_SELECTED_ROW_DETAILS_FOR_TILES = 'selectedrowdetailsfortiles';


const CUSTOM_EVENTS = 
{
    CUSTOM_EVENT_SELECTED_ROW_DETAILS,
    CUSTOM_EVENT_SELECTED_ROW_DETAILS_FOR_TILES
};

Object.freeze(CUSTOM_EVENTS);

export 
{
    CUSTOM_EVENTS
};
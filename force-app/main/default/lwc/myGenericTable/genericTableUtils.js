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
//Exporting a function
const listOfSplitedStrings = function(stringliteral)
{
    if(!Object.is(stringliteral, null) && !Object.is(stringliteral, '')) 
    {
        return stringliteral.split(',');
    }
}

export {listOfSplitedStrings};
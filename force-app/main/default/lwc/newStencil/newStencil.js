/*
*    Purpose         :   Stencils Template - To be used while component loading 
*	Created By      :   Amit Kumar
*	Created Date    :   06/15/2023
*	Current Version :   v1.0
*	Revision Log    :   V_1.0 Created - Amit Kumar - 06/15/2023
*/
import { LightningElement, track} from 'lwc';

//Importing Static Resource
import logo_icon from '@salesforce/resourceUrl/FltpLogoWhite';
import user_icon from '@salesforce/resourceUrl/User_Icon';

export default class NewStencil extends LightningElement 
{
    logoIcon = logo_icon;
    userIcon = user_icon;
    
    @track squares = [];

    connectedCallback() {
        // Generate three squares
        for (let i = 1; i <= 3; i++) {
            this.squares.push({ id: i });
        }
    }
}
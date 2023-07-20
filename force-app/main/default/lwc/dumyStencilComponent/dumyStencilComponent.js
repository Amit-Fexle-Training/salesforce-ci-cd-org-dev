import { LightningElement, api} from 'lwc';
export default class DumyStencilComponent extends LightningElement 
{
    @api count = 1; // Default value of 1 stencil container
    stencilArray = []; // Array to store stencil containers

    connectedCallback() {
        this.count = parseInt(this.count, 10); // Convert count to a number
        
        for (let i = 0; i < this.count; i++) {
            this.stencilArray.push(i);
        }
    }
}
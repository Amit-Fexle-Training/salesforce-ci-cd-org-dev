import { LightningElement } from 'lwc';
export default class GrandParentComponent extends LightningElement 
{
    constructor() {
        super();
        console.log('This is Grand Parent Constructor');
    }

    connectedCallback() {
        console.log('This is Grand Parent connectedCallback');
    }

    renderedCallback(){
        console.log('This is Grand Parent renderedCallback');
    }
}
import { LightningElement } from 'lwc';
export default class GrandChildComponent extends LightningElement 
{
    constructor() {
        super();
        console.log('This is Grand Child Constructor');
    }

    connectedCallback() {
        console.log('This is Grand Child connectedCallback');
    }

    renderedCallback(){
        console.log('This is Grand Child renderedCallback');
    }
}
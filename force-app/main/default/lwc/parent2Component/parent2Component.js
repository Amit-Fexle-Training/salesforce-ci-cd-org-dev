import { LightningElement } from 'lwc';
export default class Parent2Component extends LightningElement 
{
    constructor() {
        super();
        console.log('This is Parent2 Constructor');
    }

    connectedCallback() {
        console.log('This is Parent2 connectedCallback');
    }

    renderedCallback(){
        console.log('This is Parent2 renderedCallback');
    }
}
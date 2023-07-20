import { LightningElement } from 'lwc';
export default class Parent1Component extends LightningElement 
{
    constructor() {
        super();
        console.log('This is Parent1 Constructor');
    }

    connectedCallback() {
        console.log('This is Parent1 connectedCallback');
    }

    renderedCallback(){
        console.log('This is Parent1 renderedCallback');
    }
}
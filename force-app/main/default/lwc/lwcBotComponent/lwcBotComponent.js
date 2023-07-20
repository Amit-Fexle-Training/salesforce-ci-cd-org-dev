import { LightningElement, track } from 'lwc';

//Importing Apex Classes
import getGPTResponse from '@salesforce/apex/lwcBotComponentController.getResponse';

export default class LwcBotComponent extends LightningElement {
    @track isUser = false;
    @track isBot = false;
    @track messageInput = '';
    @track gptResponse = '';

    handleChange(event) {
        if (event && event.target) {
            this.messageInput = event.target.value;
        }
    }

    handleSendMessage() {
        this.isUser = false;
        this.isBot = false;

        getGPTResponse
            (
                {
                    messageText : this.messageInput
                }
            )
            .then((result) => {
                this.gptResponse = result;
                if (this.gptResponse && this.gptResponse.trim() !== '') {
                    this.isUser = true;
                    this.isBot = true;
                }
                else {
                    this.isUser = true;
                    this.isBot = true;
                    this.gptResponse = 'Error generating ChatGPT response: Empty response';
                    console.error('Error generating ChatGPT response: Empty response');
                }
            }
            )
            .catch((error) => {
                console.log('@@@@ ' + JSON.stringify(error));
            })
            .finally(() => {
                consol.log('@@@ : messageInput' + this.messageInput);
                consol.log('@@@ : gptResponse' + this.gptResponse);
            });
    }
}
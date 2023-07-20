import { LightningElement, track} from 'lwc';

//Importing Apex Classes
import getGPTImageResponse from '@salesforce/apex/lwcBotComponentController.getImage';

export default class ImageGPTComponent extends LightningElement {
    @track isBot = false;
    @track messageInput = '';
    @track images = [];

    handleChange(event) {
        if (event && event.target) {
            this.messageInput = event.target.value;
        }
    }

    handleSendMessage() {
        this.isBot = false;

        getGPTImageResponse
            (
                {
                    messageText : this.messageInput
                }
            )
            .then((result) => {
                this.images = result;
                if (this.images.length >= 0) {
                    this.isBot = true;
                    
                }
                else {
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
            });
    }
}
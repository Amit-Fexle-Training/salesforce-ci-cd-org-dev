import { LightningElement, track} from 'lwc';

import logo_icon from '@salesforce/resourceUrl/FltpLogoWhite';
import user_icon from '@salesforce/resourceUrl/User_Icon';

export default class InteractWithAIComponent extends LightningElement {
    @track componentName = 'FEXLE GPT';
    @track isHome = true;
    @track isCard1Selected = false;
    @track isCard2Selected = false;
    @track isCard3Selected = false;

    cards = [
        {
            id: '1',
            imageUrl: logo_icon,
            title: 'Chat',
            description: 'AI Tool To Ask Questions AND Queryies',
        },
        {
            id: '2',
            imageUrl: user_icon,
            title: 'Image Generation',
            description: 'AI Tool To Generate Artificial Image',
        },
        {
            id: '3',
            imageUrl: user_icon,
            title: 'Text Modification',
            description: 'AI Tool To Modify Text As Per Given Instruction',
        },
    ];

    handleCardClick(event) {
        console.log('Inside handleCardClick');
        const cardId = event.currentTarget.dataset.cardId;
        console.log('CardId : ' + cardId);
        if(cardId == 1)
        {
            this.isHome = false;
            this.isCard1Selected = true;
        }
        else if(cardId == 2)
        {
            this.isHome = false;
            this.isCard2Selected = true;
        }
        else
        {
            this.isHome = false;
            this.isCard3Selected = true;
        }
    }

    handleClick(event){
        this.isCard1Selected = false;
        this.isCard2Selected = false;
        this.isCard3Selected = false;
        this.isHome = true;
    }
}
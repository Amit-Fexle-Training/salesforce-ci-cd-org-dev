import { LightningElement, track} from 'lwc';

export default class ImageCarouselComponent extends LightningElement 
{
    @track images = [
        {
            id : '1',
            src : 'https://www.lightningdesignsystem.com/assets/images/carousel/carousel-01.jpg',
            header : 'First Card',
            description : 'First card description.',
            altText : 'First card accessible description.',
            href : 'javascript:void(0);',
        },
        {
            id : '2',
            src : 'https://www.lightningdesignsystem.com/assets/images/carousel/carousel-02.jpg',
            header : 'Second Card',
            description : 'Second card description.',
            altText : 'Second card accessible description.',
            href : 'javascript:void(0);',
        },
        {
            id : '3',
            src : 'https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg',
            header : 'Third Card',
            description : 'Third card description.',
            altText : 'Third card accessible description.',
            href : 'javascript:void(0);',
        }
    ];

}
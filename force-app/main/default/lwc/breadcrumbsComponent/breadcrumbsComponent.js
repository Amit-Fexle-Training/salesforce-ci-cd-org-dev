import { LightningElement, track} from 'lwc';
export default class BreadcrumbsComponent extends LightningElement 
{
    @track showModule = true;
    @track showSession = true;

    updateBreadcrumbs(event) 
    {
        const currentPage = event.detail.page;
        if (currentPage === 'technology') {
            this.showModule = false;
            this.showSession = false;
        } else if (currentPage === 'module') {
            this.showModule = true;
            this.showSession = false;
        } else if (currentPage === 'session') {
            this.showModule = true;
            this.showSession = true;
        }
    }

    handleNavigateToTechnology(event) {
        console.log('Clicked : ' + event.target.label);
        this.showModule = false;
        this.showSession = false;
        this.showContainerComponent = false;
        setTimeout(() => {
                    this.showContainerComponent = true;
                }, DELAY_OF_1_SECOND
                );
    }

    handleNavigateToModule(event) {
        console.log('Clicked : ' + event.target.label);
        this.showSession = false;
        
        this.showModules = false;
        setTimeout(() => {
                    this.showModules = true;
                }, DELAY_OF_1_SECOND
                );
    }

    handleNavigateToSession(event) {
        console.log('Clicked : ' + event.target.label);

        this.showSessions = false;
        setTimeout(() => {
                    this.showSessions = true;
                }, DELAY_OF_1_SECOND
                );
    }
}
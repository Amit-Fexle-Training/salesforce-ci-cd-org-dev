import { LightningElement } from 'lwc';
export default class GoogleMapComponent extends LightningElement {
    mapMarkers;
  zoomLevel;
  listView;
  connectedCallback() {
    this.mapMarkers = [
      {
        location: {
          City: "Varanasi",
          Country: "India",
          PostalCode: "221001",
          State: "Uttar Pradesh",
          Street: "Koniya"
        },
        title: "Amit Kumar",
        description: "I am here",
        icon: "standard:account"
      }
    ];
    //Google Maps API supports zoom levels from 1 to 22 in desktop browsers, and from 1 to 20 on mobile.
    this.zoomLevel = 10;
    this.listView = "visible";
  }
}
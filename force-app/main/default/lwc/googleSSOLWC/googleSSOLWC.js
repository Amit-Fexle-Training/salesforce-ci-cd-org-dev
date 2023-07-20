import { LightningElement } from 'lwc';

export default class GoogleSSOLWC extends LightningElement {
    connectedCallback() {
    // Load the Google API platform script dynamically
    const script = document.createElement('script');
    script.src = 'https://apis.google.com/js/platform.js';
    script.async = true;
    script.defer = true;
    document.head.appendChild(script);

    // Define your Google Sign-In client ID
    const clientId = '150589326614-b7ofmurc1brppslhu8toe9m4hmngr25e.apps.googleusercontent.com.apps.googleusercontent.com';
    const meta = document.createElement('meta');
    meta.name = 'google-signin-client_id';
    meta.content = clientId;
    document.head.appendChild(meta);
  }

  onSignIn() {
    const profile = googleUser.getBasicProfile();
    console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
    console.log('Name: ' + profile.getName());
    console.log('Image URL: ' + profile.getImageUrl());
    console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
  }
}
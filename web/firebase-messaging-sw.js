importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

firebase.initializeApp({
    apiKey: 'AIzaSyDJqTNdoyNZ95ijwdto7MJ3Rblue48a_Eg',
    appId: '1:751293249732:web:ad282c9fd0a744d9ec3191',
    messagingSenderId: '751293249732',
    projectId: 'web-notification-d7e70',
    authDomain: 'web-notification-d7e70.firebaseapp.com',
    storageBucket: 'web-notification-d7e70.appspot.com',
    measurementId: 'G-ME3DPJM3Y2',
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.4.1/firebase-messaging.js');

// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDJqTNdoyNZ95ijwdto7MJ3Rblue48a_Eg",
  authDomain: "web-notification-d7e70.firebaseapp.com",
  projectId: "web-notification-d7e70",
  storageBucket: "web-notification-d7e70.appspot.com",
  messagingSenderId: "751293249732",
  appId: "1:751293249732:web:966d60f00b9e61bfec3191",
  measurementId: "G-51MD9KB1ST"
};

// Initialize Firebase
//const app = initializeApp(firebaseConfig);
//const analytics = getAnalytics(app);

 firebase.initializeApp(firebaseConfig);
 const messaging = firebase.messaging();
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
  console.log("onBackgroundMessage", m);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});
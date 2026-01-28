// Firebase SDKs
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.0/firebase-app.js";
import { getAuth } from "https://www.gstatic.com/firebasejs/10.12.0/firebase-auth.js";

// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyChWtgnNZRwmJ51PgucQnfEubFqn_2120I",
  authDomain: "mforce-b11b6.firebaseapp.com",
  projectId: "mforce-b11b6",
  storageBucket: "mforce-b11b6.firebasestorage.app",
  messagingSenderId: "114433218065",
  appId: "1:114433218065:web:91702ad7b5e94ab9ad83b0",
  measurementId: "G-VB5R5N4H62"
};

// Init
const app = initializeApp(firebaseConfig);
const auth = getAuth(app);

export { auth };

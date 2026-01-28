import { auth } from "./firebase.js";
import {
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword
} from "https://www.gstatic.com/firebasejs/10.12.0/firebase-auth.js";

// UI switch
window.showRegister = function () {
  document.getElementById("login-form").classList.add("hidden");
  document.getElementById("register-form").classList.remove("hidden");
};

window.showLogin = function () {
  document.getElementById("register-form").classList.add("hidden");
  document.getElementById("login-form").classList.remove("hidden");
};

// Register
document.getElementById("register-form").addEventListener("submit", e => {
  e.preventDefault();

  const email = e.target[1].value;
  const password = e.target[2].value;

  createUserWithEmailAndPassword(auth, email, password)
    .then(() => {
      alert("Account created. Please login.");
      showLogin();
    })
    .catch(err => alert(err.message));
});

// Login
document.getElementById("login-form").addEventListener("submit", e => {
  e.preventDefault();

  const email = e.target[0].value;
  const password = e.target[1].value;

  signInWithEmailAndPassword(auth, email, password)
    .then(() => {
      window.location.href = "web/token.html";
    })
    .catch(err => alert(err.message));
});

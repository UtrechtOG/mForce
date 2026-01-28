import { auth } from "./firebase.js";
import {
  signInWithEmailAndPassword,
  createUserWithEmailAndPassword,
  GoogleAuthProvider,
  signInWithPopup
} from "https://www.gstatic.com/firebasejs/9.23.0/firebase-auth.js";

const loginBox = document.getElementById("loginBox");
const registerBox = document.getElementById("registerBox");

document.getElementById("showRegister").onclick = () => {
  loginBox.classList.add("hidden");
  registerBox.classList.remove("hidden");
};

document.getElementById("showLogin").onclick = () => {
  registerBox.classList.add("hidden");
  loginBox.classList.remove("hidden");
};

// Email Login
document.getElementById("loginBtn").onclick = async () => {
  if (!document.getElementById("robotLogin").checked) {
    alert("Please confirm you are not a robot");
    return;
  }
  const email = document.getElementById("loginEmail").value;
  const password = document.getElementById("loginPassword").value;

  try {
    await signInWithEmailAndPassword(auth, email, password);
    window.location.href = "web/token.html";
  } catch (e) { alert(e.message); }
};

// Register
document.getElementById("registerBtn").onclick = async () => {
  if (!document.getElementById("robotRegister").checked) {
    alert("Please confirm you are not a robot");
    return;
  }
  const email = document.getElementById("regEmail").value;
  const password = document.getElementById("regPassword").value;

  try {
    await createUserWithEmailAndPassword(auth, email, password);
    alert("Account created. Please login.");
    document.getElementById("showLogin").click();
  } catch (e) { alert(e.message); }
};

// Google Login
document.getElementById("googleLogin").onclick = async () => {
  if (!document.getElementById("robotLogin").checked) {
    alert("Please confirm you are not a robot");
    return;
  }
  try {
    const provider = new GoogleAuthProvider();
    await signInWithPopup(auth, provider);
    window.location.href = "web/token.html";
  } catch (e) { alert(e.message); }
};

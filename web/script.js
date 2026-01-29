import { auth, db } from "./firebase.js";
import {
  signInWithEmailAndPassword,
  createUserWithEmailAndPassword,
  GoogleAuthProvider,
  signInWithPopup,
  onAuthStateChanged
} from "https://www.gstatic.com/firebasejs/9.23.0/firebase-auth.js";

import {
  doc,
  getDoc,
  setDoc
} from "https://www.gstatic.com/firebasejs/9.23.0/firebase-firestore.js";

function generateToken() {
  return "mf_" + crypto.randomUUID().replaceAll("-", "");
}

document.addEventListener("DOMContentLoaded", () => {

  /* ---------- UI ---------- */
  const loginBox = document.getElementById("loginBox");
  const registerBox = document.getElementById("registerBox");

  const showRegister = document.getElementById("showRegister");
  const showLogin = document.getElementById("showLogin");

  const loginBtn = document.getElementById("loginBtn");
  const registerBtn = document.getElementById("registerBtn");
  const googleBtn = document.getElementById("googleLogin");

  showRegister.onclick = () => {
    loginBox.classList.add("hidden");
    registerBox.classList.remove("hidden");
  };

  showLogin.onclick = () => {
    registerBox.classList.add("hidden");
    loginBox.classList.remove("hidden");
  };

  /* ---------- LOGIN ---------- */
  loginBtn.onclick = async () => {
    if (!document.getElementById("robotLogin").checked) {
      alert("Please confirm you are not a robot");
      return;
    }

    try {
      await signInWithEmailAndPassword(
        auth,
        loginEmail.value,
        loginPassword.value
      );
    } catch (e) {
      alert(e.message);
    }
  };

  /* ---------- REGISTER ---------- */
  registerBtn.onclick = async () => {
    if (!document.getElementById("robotRegister").checked) {
      alert("Please confirm you are not a robot");
      return;
    }

    try {
      await createUserWithEmailAndPassword(
        auth,
        regEmail.value,
        regPassword.value
      );
      alert("Account created. Please login.");
      showLogin.click();
    } catch (e) {
      alert(e.message);
    }
  };

  /* ---------- GOOGLE ---------- */
  googleBtn.onclick = async () => {
    if (!document.getElementById("robotLogin").checked) {
      alert("Please confirm you are not a robot");
      return;
    }

    try {
      const provider = new GoogleAuthProvider();
      await signInWithPopup(auth, provider);
    } catch (e) {
      alert(e.message);
    }
  };

});

/* ---------- AUTH STATE (GLOBAL) ---------- */

onAuthStateChanged(auth, async (user) => {
  if (!user) return;

  try {
    const ref = doc(db, "users", user.uid);
    const snap = await getDoc(ref);

    if (!snap.exists() || !snap.data().token) {
      await setDoc(ref, {
        token: generateToken(),
        created: Date.now()
      }, { merge: true });
    }

    window.location.href = "web/token.html";
  } catch (err) {
    alert("Token setup failed");
  }
});

// mForce Web Auth
// Version: v0.03.1-web-auth-debug

document.addEventListener("DOMContentLoaded", () => {
  const badge = document.createElement("div");
  badge.innerText = "mForce Web v0.03.1";
  badge.style.position = "fixed";
  badge.style.bottom = "10px";
  badge.style.right = "10px";
  badge.style.background = "#0a0f1e";
  badge.style.color = "#6cf";
  badge.style.border = "1px solid #263055";
  badge.style.padding = "6px 10px";
  badge.style.fontSize = "12px";
  badge.style.borderRadius = "6px";
  badge.style.zIndex = "9999";
  document.body.appendChild(badge);
});

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

/* ---------- SAFE TOKEN GENERATOR (MOBILE COMPATIBLE) ---------- */
function generateToken() {
  const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  let out = "mf_";
  for (let i = 0; i < 32; i++) {
    out += chars[Math.floor(Math.random() * chars.length)];
  }
  return out;
}

/* ---------- UI & EVENTS ---------- */
document.addEventListener("DOMContentLoaded", () => {

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

  // Email Login
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

  // Register
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

  // Google Login
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

/* ---------- AUTH STATE (TOKEN + REDIRECT) ---------- */
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

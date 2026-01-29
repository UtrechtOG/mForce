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

/* ---------------- UI ---------------- */

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

/* ---------------- TOKEN ---------------- */

function generateToken() {
  return "mf_" + crypto.randomUUID().replaceAll("-", "");
}

/* ---------------- AUTH ACTIONS ---------------- */

// Email Login
document.getElementById("loginBtn").onclick = async () => {
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
document.getElementById("registerBtn").onclick = async () => {
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
    document.getElementById("showLogin").click();
  } catch (e) {
    alert(e.message);
  }
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
  } catch (e) {
    alert(e.message);
  }
};

/* ---------------- AUTH STATE (ZENTRAL) ---------------- */

onAuthStateChanged(auth, async (user) => {
  if (!user) return;

  try {
    const ref = doc(db, "users", user.uid);
    const snap = await getDoc(ref);

    // 🔥 Token IMMER sicherstellen
    if (!snap.exists() || !snap.data().token) {
      await setDoc(ref, {
        token: generateToken(),
        created: Date.now()
      }, { merge: true });
    }

    // erst JETZT weiterleiten
    window.location.href = "web/token.html";
  } catch (err) {
    alert("Token creation failed");
    console.error(err);
  }
});

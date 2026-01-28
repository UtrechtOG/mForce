function showRegister() {
  document.getElementById("login-form").classList.add("hidden");
  document.getElementById("register-form").classList.remove("hidden");
}

function showLogin() {
  document.getElementById("register-form").classList.add("hidden");
  document.getElementById("login-form").classList.remove("hidden");
}

function copyToken() {
  const token = document.querySelector(".token-box code").innerText;
  navigator.clipboard.writeText(token);
  alert("Token copied to clipboard");
}

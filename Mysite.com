<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>AI Video Generator & Chat Platform</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- ===================== CSS START ===================== -->
<style>
/* ===== GLOBAL STYLES ===== */
*{
    box-sizing:border-box;
    margin:0;
    padding:0;
}
body{
    font-family:Arial, Helvetica, sans-serif;
    background:linear-gradient(135deg,#020617,#0f172a);
    color:#fff;
}

/* ===== HEADER ===== */
header{
    background:#020617;
    padding:25px;
    text-align:center;
    border-bottom:2px solid #22c55e;
}
header h1{
    color:#22c55e;
    font-size:28px;
}
header p{
    color:#cbd5f5;
    margin-top:8px;
}

/* ===== NAVBAR ===== */
nav{
    background:#020617;
    display:flex;
    justify-content:center;
    gap:20px;
    padding:15px;
}
nav a{
    color:#22c55e;
    text-decoration:none;
    font-weight:bold;
}
nav a:hover{
    text-decoration:underline;
}

/* ===== CONTAINER ===== */
.container{
    max-width:1100px;
    margin:auto;
    padding:20px;
}

/* ===== BOX DESIGN ===== */
.box{
    background:#1e293b;
    padding:25px;
    margin:25px 0;
    border-radius:12px;
    box-shadow:0 0 20px rgba(0,0,0,0.5);
}
.box h2{
    color:#22c55e;
    margin-bottom:15px;
}

/* ===== INPUT & BUTTON ===== */
input, textarea{
    width:100%;
    padding:12px;
    margin:10px 0;
    border-radius:6px;
    border:none;
    outline:none;
}
button{
    padding:12px 25px;
    background:#22c55e;
    color:#000;
    border:none;
    border-radius:6px;
    font-weight:bold;
    cursor:pointer;
}
button:hover{
    background:#16a34a;
}

/* ===== CHAT ===== */
#chatArea{
    background:#020617;
    height:200px;
    padding:10px;
    overflow-y:auto;
    border-radius:6px;
}
.msg{
    margin:8px 0;
}

/* ===== VIDEO RESULT ===== */
#videoResult{
    margin-top:15px;
    color:#facc15;
}

/* ===== LOGIN ===== */
.login-box{
    max-width:400px;
    margin:auto;
}

/* ===== FOOTER ===== */
footer{
    background:#020617;
    text-align:center;
    padding:20px;
    margin-top:40px;
    color:#94a3b8;
    font-size:14px;
}
</style>
<!-- ===================== CSS END ===================== -->
</head>

<body>

<!-- ===================== HEADER ===================== -->
<header>
    <h1>🎬 AI Video Generator & Chat Platform</h1>
    <p>Generate AI Videos • Chat Instantly • Smart Platform</p>
</header>

<!-- ===================== NAV ===================== -->
<nav>
    <a href="#login">Login</a>
    <a href="#video">Video Generator</a>
    <a href="#chat">Chat</a>
    <a href="#about">About</a>
</nav>

<div class="container">

<!-- ===================== LOGIN SECTION ===================== -->
<div class="box login-box" id="login">
    <h2>👤 User Login (Demo)</h2>
    <input type="text" id="username" placeholder="Enter username">
    <button onclick="loginUser()">Login</button>
    <p id="loginStatus"></p>
</div>

<!-- ===================== VIDEO GENERATOR ===================== -->
<div class="box" id="video">
    <h2>🎥 AI Video Generator</h2>
    <p>Describe your video idea below:</p>
    <textarea id="videoPrompt" placeholder="Example: A lion walking in jungle with cinematic effect"></textarea>
    <button onclick="generateVideo()">Generate Video</button>
    <div id="videoResult"></div>
</div>

<!-- ===================== CHAT SECTION ===================== -->
<div class="box" id="chat">
    <h2>💬 AI Chat System</h2>
    <div id="chatArea"></div>
    <input type="text" id="chatInput" placeholder="Type your message...">
    <button onclick="sendMessage()">Send</button>
</div>

<!-- ===================== ABOUT ===================== -->
<div class="box" id="about">
    <h2>ℹ️ About This Website</h2>
    <p>
        This platform is designed for users who want to generate AI videos
        and chat instantly on a single website.  
        This is a demo version showing how an AI website works.
    </p>
    <p>
        In future, real AI APIs like Runway, Pika, Haiper and ChatGPT
        can be connected to make it fully functional.
    </p>
</div>

</div>

<!-- ===================== FOOTER ===================== -->
<footer>
    © 2025 AI Video Generator & Chat Website  
    <br>
    Built with ❤️ using HTML, CSS & JavaScript
</footer>

<!-- ===================== JAVASCRIPT START ===================== -->
<script>
let currentUser = "";

/* ===== LOGIN FUNCTION ===== */
function loginUser(){
    let user = document.getElementById("username").value;
    let status = document.getElementById("loginStatus");

    if(user === ""){
        status.innerText = "❌ Please enter username";
        return;
    }
    currentUser = user;
    status.innerText = "✅ Welcome " + user + "!";
}

/* ===== VIDEO GENERATOR ===== */
function generateVideo(){
    let prompt = document.getElementById("videoPrompt").value;
    let result = document.getElementById("videoResult");

    if(prompt === ""){
        result.innerHTML = "❌ Please enter a video idea.";
    }else{
        result.innerHTML = 
        "🎬 <b>Generating Video...</b><br>" +
        "Prompt: " + prompt + "<br>" +
        "⏳ This is a demo. Real AI will be connected later.";
    }
}

/* ===== CHAT FUNCTION ===== */
function sendMessage(){
    let input = document.getElementById("chatInput");
    let chatArea = document.getElementById("chatArea");

    if(input.value === "") return;

    let userMsg = document.createElement("div");
    userMsg.className = "msg";
    userMsg.innerHTML = "👤 <b>" + (currentUser || "Guest") + ":</b> " + input.value;
    chatArea.appendChild(userMsg);

    let botMsg = document.createElement("div");
    botMsg.className = "msg";
    botMsg.innerHTML = "🤖 <b>AI:</b> Your message has been received.";
    chatArea.appendChild(botMsg);

    input.value = "";
    chatArea.scrollTop = chatArea.scrollHeight;
}
</script>
<!-- ===================== JAVASCRIPT END ===================== -->

</body>
</html>

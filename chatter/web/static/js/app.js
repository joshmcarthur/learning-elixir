// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html";
import { Socket, Presence } from "phoenix";

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket";

let user = document.getElementById("user").innerText;
let socket = new Socket("/socket", { params: { user: user } });
socket.connect();

let presences = {};
let formattedTimestamp = ts => {
  let date = new Date(ts);
  return date.toLocaleString();
};

let listBy = (user, { metas }) => {
  return {
    user,
    onlineAt: formattedTimestamp(metas[0].online_at)
  };
};

let userList = document.getElementById("userList");
let render = presences => {
  userList.innerHTML = Presence.list(presences, listBy)
    .map(
      presence => `
    <li>
      ${presence.user}
      <br>
      <small>online since ${presence.onlineAt}</small>
    </li>
  `
    )
    .join("");
};

let room = socket.channel("room:lobby");
room.on("presence_state", state => {
  presences = Presence.syncState(presences, state);
  render(presences);
});

room.on("presence_diff", diff => {
  presences = Presence.syncDiff(presences, diff);
  render(presences);
});

room.join();

let messageForm = document.getElementById("new-message-form");
let messageInput = document.getElementById("newMessage");
messageForm.addEventListener("submit", e => {
  e.preventDefault();
  if (messageInput.value == "") return;
  room.push("message:new", messageInput.value);
  e.currentTarget.reset();
});

let messageList = document.getElementById("messageList");
let renderMessage = message => {
  let messageElement = document.createElement("li");
  messageElement.innerHTML = `
    <b>${message.user}</b>
    <i>${formattedTimestamp(message.timestamp)}</li>
    <p>${message.body}</p>
  `;

  messageList.appendChild(messageElement);
};

room.on("message:new", renderMessage);

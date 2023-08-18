// ==UserScript==
// @name        Keep Full Screen
// @namespace   http://superuser.com/q/315949
// @description Prevents Escape key from leaving full screen.
// @include     https://*
// ==/UserScript==
this.addEventListener("keypress", (e) => {
  if (e.key == "Escape") {
    e.preventDefault();
  }
});

// import { Main } from 'dist/elm.js'

var storedState = localStorage.getItem('geg-redhounds');
var startingState = storedState ? JSON.parse(storedState) : 0;

var app = Elm.Main.init({
    // node: document.getElementById("elm-app-is-loaded-here"),
    flags: startingState
})
// you can use ports and stuff here


app.ports.setStorage.subscribe(function(state) {
    localStorage.setItem('geg-redhounds', JSON.stringify(state));
});
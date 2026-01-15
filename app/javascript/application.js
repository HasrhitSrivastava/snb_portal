// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import $ from "jquery"
window.$ = $
window.jQuery = $

import "select2/dist/js/select2.full"

window.toggleMenu = function () {
    const x = document.getElementById("myLinks");
    x.style.display = (x.style.display === "block") ? "none" : "block";
};

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "jquery"
import "select2"
import "select2_init"

window.toggleMenu = function () {
    const x = document.getElementById("myLinks");
    x.style.display = (x.style.display === "block") ? "none" : "block";
};

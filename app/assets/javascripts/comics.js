 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.
 // You can use CoffeeScript in this file: http://coffeescript.org/

var slideIndex = 0;

function slideNext() {
  slideIndex++;
  showSlide();
}

function slidePrev() {
  slideIndex--;
  showSlide();
}

function showSlide() {
  var i;
  comic = document.getElementsByClassName("medium");
  for (i = 0; i < comic.length; i++) {
    comic[i].style.display = "none";
  }

  if (slideIndex >= comic.length) {slideIndex = comic.length - 1}
  if (0 > slideIndex) {slideIndex = 0}
  comic[slideIndex].style.display = "block";
}

$(document).ready(
  function() {
    showSlide();
  }
);

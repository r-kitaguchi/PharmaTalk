// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

window.onload = document.addEventListener("turbolinks:load", function(){
                                            popupSetting()
                                          });

function popupSetting(){
  let popupSignUp = document.getElementById('popup_sign_up');
  let popupLogIn = document.getElementById('popup_log_in');
  if(!popupSignUp && !popupLogIn) return;

  let logInBtn = document.querySelectorAll('.js_log_in');
  let logInClose = document.getElementById('log_in_close');
  let logInBlack = document.getElementById('log_in_black');

  let signUpBtn = document.querySelectorAll('.js_sign_up');
  let signUpClose = document.getElementById('sign_up_close');
  let signUpBlack = document.getElementById('sign_up_black');

  logInPopUp(logInBlack);
  logInPopUp(logInClose);
  logInPopUp(logInBtn[0]);

  signInPopUp(signUpBlack);
  signInPopUp(signUpClose);
  signInPopUp(signUpBtn[0]);
  signInPopUp(signUpBtn[1]);

  function logInPopUp(elem) {
    if(!elem) return;

    elem.addEventListener('click', function(){
      popupLogIn.classList.toggle('is_show');
    });
  }

  function signInPopUp(elem){
    if(!elem) return;

    elem.addEventListener('click', function(){
      popupSignUp.classList.toggle('is_show');
    });
  }
}

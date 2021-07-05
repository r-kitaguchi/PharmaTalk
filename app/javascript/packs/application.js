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

function popupSetting(){
  let popup = document.getElementById('popup');
  if(!popup) return;

  let bgBlack = document.getElementById('bg_black');
  let closeBtn = document.getElementById('close_btn');
  let signUpBtn = document.querySelectorAll('.js-sign_up');

  popUp(bgBlack);
  popUp(closeBtn);
  popUp(signUpBtn[0]);
  popUp(signUpBtn[1]);

  function popUp(elem){
    if(!elem) return;

    elem.addEventListener('click', function(){
      popup.classList.toggle('is_show');
    });
  }
}

popupSetting();

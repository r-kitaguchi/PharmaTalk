document.addEventListener("turbolinks:load", function(){
  accountDeleteSetting()
});

function accountDeleteSetting(){
  let popupAccountDelete = document.getElementById('popup_account_delete');
  if(!popupAccountDelete) return;

  let accountDeleteBtn = document.querySelectorAll('.js_account_delete');
  let accountDeleteClose = document.getElementById('account_delete_close');
  let accountDeleteBlack = document.getElementById('account_delete_black');
  let accountDeleteBack = document.getElementById('account_delete_back');


  accountDeletePouUp(accountDeleteBack);
  accountDeletePouUp(accountDeleteBlack);
  accountDeletePouUp(accountDeleteClose);
  accountDeletePouUp(accountDeleteBtn[0]);

  function accountDeletePouUp(elem) {
    if(!elem) return;

    elem.addEventListener('click', function(){
      popupAccountDelete.classList.toggle('is_show')
    })
  }
}

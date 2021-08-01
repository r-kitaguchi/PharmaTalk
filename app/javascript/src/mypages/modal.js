document.addEventListener("turbolinks:load", function(){
  endTalkSetting()
});

function endTalkSetting(){
  let popupEndTalk = document.getElementById('popup_end_talk');
  if(!popupEndTalk) return;

  let endTalkBtn = document.querySelectorAll('.js_end_talk');
  let endTalkClose = document.getElementById('end_talk_close');
  let endTalkBlack = document.getElementById('end_talk_black');
  let endTalkBack = document.getElementById('end_talk_back');


  endTalkPouUp(endTalkBack);
  endTalkPouUp(endTalkBlack);
  endTalkPouUp(endTalkClose);
  endTalkPouUp(endTalkBtn[0]);

  function endTalkPouUp(elem) {
    if(!elem) return;

    elem.addEventListener('click', function(){
      popupEndTalk.classList.toggle('is_show')
    })
  }
}

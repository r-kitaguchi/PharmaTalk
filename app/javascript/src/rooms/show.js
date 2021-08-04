document.addEventListener("turbolinks:load", function(){
  scrollSet()
  document.querySelectorAll('.message_area').forEach(expandArea)
});

function scrollSet(){
  let talkRoomContent = document.getElementById('talk_room_content');
  talkRoomContent.scrollIntoView(false);
};

function expandArea(el){
  let dummy = el.querySelector('.dummy_message')
  el.querySelector('#message_content').addEventListener('input', e => {
    dummy.textContent = e.target.value + '\u200b'
  })
}

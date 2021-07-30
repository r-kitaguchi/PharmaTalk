window.onload = document.addEventListener("turbolinks:load", function(){
  scrollSet()
});

function scrollSet(){
  let talkRoomContent = document.getElementById('talk_room_content');
  talkRoomContent.scrollIntoView(false);
};

import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    console.log("Yes we are live in the channel function")
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {

    var msg_frm = '<div class="message">';
    msg_frm += '    <div class="container '+ data.is_darker+'">';
    msg_frm += '      <img src="'+ data.img +'" alt="Avatar" class="'+ data.img_pst +'">';
    msg_frm += '     <div class="'+ data.time_frame +'">';
    msg_frm += '      <p> '+ data.content+' </p>';
    msg_frm += '      <span>' + data.name +'</span>';
    msg_frm += '    </div>';
    msg_frm += '   </div>';
    msg_frm += '</div>';

    $(data.room_id).append(msg_frm)
    $("#message_content").val("");
    // Called when there's incoming data on the websocket for this channel
  }
});

var submit_messages;

$(document).on('turbolinks:load', function(){
  submit_messages()

})

submit_messages =  function(){
  $("#messages_content").on('keydown', function(event){
    if (event.keyCode === 13) {
      $('input').click()
      event.target.value = ''
      event.preventDefault()
    }
  })
}

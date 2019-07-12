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
    console.log(data.content)
    $("#msg").append('<div class="message"><span style="color:red">'+ data.name +'</span>:' + data.content +' </div>')
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

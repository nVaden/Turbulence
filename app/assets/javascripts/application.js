// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

// Toggle for Nav Menu ======

$(document).ready(function(){
    $(".button a").click(function(){
        $(".overlay").fadeToggle(200);
       $(this).toggleClass('btn-open').toggleClass('btn-close');
    });
});
$('.overlay').on('click', function(){
    $(".overlay").fadeToggle(200);   
    $(".button a").toggleClass('btn-open').toggleClass('btn-close');
    open = false;
});

function printMessage(message) {
  $('#messages').append(message + "<br>");
}

$(function() {
    var chatChannel;
    var username;
 
    function setupChannel() {
        chatChannel.join().then(function(channel) {
            printMessage(username + ' joined the chat.');
        });
 
        chatChannel.on('messageAdded', function(message) {
            printMessage(message.author + ": " + message.body);
         });
    }
 
    var $input = $('#chat-input'); 
    $input.on('keydown', function(e) {
        if (e.keyCode == 13) {
            chatChannel.sendMessage($input.val())
            $input.val('');
        }
     });
    $.post("/tokens", function(data) {
    username = data.username;
    var accessManager = new Twilio.AccessManager(data.token);
    var messagingClient = new Twilio.IPMessaging.Client(accessManager);

    messagingClient.getChannelByUniqueName('chat').then(function(channel) {
        if (channel) {
            chatChannel = channel;
            setupChannel();
        } else {
            messagingClient.createChannel({
                uniqueName: 'chat',
                friendlyName: 'Chat Channel' })
            .then(function(channel) {
                chatChannel = channel;
                setupChannel();
            });
        }
    });
});
 
});



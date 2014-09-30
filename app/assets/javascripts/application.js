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
//= require pusher
//= require_tree .

var pusher = new Pusher('95cfbff7872e752c374e');
pusher.connection.bind('state_change', function(change) {
  $('#connection_state').text(change.current);
});

var channel = pusher.subscribe('buddha_channel');
channel.bind('buddha_event', function(data) {
  $("#no-message").remove();
  $("section#message").append('<div>' + data + '</div>')
});

Pusher.log = function(msg) {
  if (console && console.log) {
    console.log(msg);
  }
};
$(function(){ $(document).foundation(); });

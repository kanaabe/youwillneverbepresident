$(function(){
  var files = ["http://24.media.tumblr.com/tumblr_m6z9jmNuuq1ra42tbo1_500.gif","http://images.huffingtonpost.com/2013-08-23-tumblr_m08celcrnT1r3isxuo1_500.gif","http://i613.photobucket.com/albums/tt218/darthnull/Emoticons/digging.gif","http://i.giphy.com/Lnjqt0t2UUZGw.gif"];
  var text = ["Discovering your inner-most secrets", "Computing, computing, detecting...", "Digging through all your tweets","Just a moment, please"];
  if($('#results-page').length > 0) {
    $.ajax({
  	  type: "GET",
      url: '/users',
      dataType: 'script',
      beforeSend: function() {
        for(var i = 0; i < files.length; i ++){
          setTime(i);
        }
      },
      success: function() {
        $('#load_img').hide();
        $('#load_text').hide();
        $('#load-banner').hide();
      }
  	});
  }

  function setTime(i){
    setTimeout(function(){
      $("#load_img").attr("src",files[i]);
      $('#load_text')[0].innerHTML = text[i];
    },6000*i);
  }
});

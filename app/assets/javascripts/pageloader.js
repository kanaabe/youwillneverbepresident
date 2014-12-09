$(function(){


    if($('#results-page').length > 0) {
        $.ajax({
    	type: "GET",
        url: '/users',
        dataType: 'script',
        beforeSend: function() { 
        	$('#twitter_load_img').show();
        },
        success: function() {
          $('#twitter_load_img').hide();
        }
    	});
    }
});
$( document ).ready(function() {

	//if play icon is clicked
  	$('.play').click(function() {

  		var audio = $('audio', this)[0];

  		if(audio.paused)
  			audio.play();
  		else
  			audio.pause();

  		$('span', this).toggleClass("glyphicon-play");
  		$('span', this).toggleClass("glyphicon-pause");

  		});

  	//if pause icon is clicked
  	// $('.glyphicon-pause').click(function() {

  	// 	$('audio', this)[0].pause();

  	// 	$(this).toggleClass("glyphicon-pause");
  	// 	$(this).toggleClass("glyphicon-play");

  	// 	});
});
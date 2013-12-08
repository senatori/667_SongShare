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

		var allowClose = false;
		$('#myDropdown').on({
		    "shown.bs.dropdown": function() { allowClose = false; },
		    "click":             function() { allowClose = true; },
		    "hide.bs.dropdown":  function() { if (!allowClose) return false; }
		});
  	//if pause icon is clicked
  	// $('.glyphicon-pause').click(function() {

  	// 	$('audio', this)[0].pause();

  	// 	$(this).toggleClass("glyphicon-pause");
  	// 	$(this).toggleClass("glyphicon-play");

  	// 	});
});
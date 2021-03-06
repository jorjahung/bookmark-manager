$(function () {
	console.log($("*").length);
});

// to make the star solid and hollow on click
function addFavouritesHandler() {
	$(".star.solid").click(function(event) {
		// get the link this star belongs to
		var link = $(this).parent()
		// get a booklean value for 'favourited'
		// double negation casts any value to boolean
		var favourited = !!$(link).data("favourited");
		var newOpacity =favourited ? 0 : 1;
		// toggle the "favouited" variable on the link element
		$(link).data("favourited", !favourited);
		//perform the animation
		$(this).animate({opacity:newOpacity}, 1000);
		showLinkFavouritedNotice(link)
	});
};

$(function() {
	addFavouritesHandler();
	prepareRemoteFormsHandler();
});

function showLinkFavouritedNotice(link) {
	var favourited = !!$(link).data("favourited");
	// get the text of the .title element
	// that we find among the children of link
	var name = $(link).find('.title').text();
	var message = favourited ?
								name + " was added to favourites" :
								name + " was removed from favourites";
	var flash = $("<div></div>").addClass('flash notice').html(message);
	$(flash).appendTo('#flash-container');
	window.setTimeout(function() {
		$(flash).fadeOut();	
	}, 2000);
};

function prepareFormHandler() {
	var form = $('#links-container #ajax-form form');
	form.submit(function(event) {
		var addLink = function(data) {
			$('#links').prepend(data);
		}
		var data = form.serialize();
		$.post(form.attr('action'), data, addLink);
		event.preventDefault();
	});
};

function prepareRemoteFormsHandler() {
	$('.add-link, #sign-up, #sign-in, #forgot-password').click(function(event) {
		$.get($(this).attr('href'), function(data) { 
			if ($("#ajax-form").length==0) {
				$("#links-container").prepend("<div id='ajax-form'></div>");
			}
			$('#links-container #ajax-form').html(data);
		});
		// prevents the browser from sending a GET request:
		event.preventDefault();
	});
};
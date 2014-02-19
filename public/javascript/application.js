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
});

function showLinkFavouritedNotice(link) {
	var favourited = !!$(link).data("favourited");
	// get the text of the .title element
	// that we find among the children of link
	var name = $(link).find('.title').text();
	var message = favourited ?
								name + " was added to favourites" :
								name + " was removed from favourites";
	var $flash = $("<div></div>").addClass('flash notice').html(message);
	$flash.appendTo('#flash-container');
}
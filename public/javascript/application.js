$(function () {
	console.log($("*").length);
});

function addFavouritesHandler() {
	$(".star.solid").click(function(event) {
		var newOpacity = 1 - parseInt($(this).css('opacity'));
		$(this).animate({opacity:newOpacity}, 500);
	});
};

$(function() {
	addFavouritesHandler();
});
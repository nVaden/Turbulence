
// Loading Screen JS 

// --------------
var animate = setTimeout(function() {
		$('body').addClass('loaded');
	}, 800);

$(document).ready(animate);
$(document).on('page:change', animate);

jQuery ($) ->
		$(window).on 'scroll', ->
  		url = $('.pagination .next_page a').attr('href');
				if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
  				$('.pagination').text('Fetching more items...')
  				$.getScript url
  	$(window).on 'scroll'
  	console.log($);

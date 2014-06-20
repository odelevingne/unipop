jQuery ->
  if $('#infinite-scrolling').size() > 0
  	paginationScroller = ->
      more_listings_url = $('.pagination .next_page a').attr('href')
      
      if more_listings_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $(".loader").show()
        $.getScript more_listings_url, ->
        	$(".loader").hide()
      return
    return

    throttled = _.throttle(paginationScroller, 200);

    $(window).on 'scroll', throttled
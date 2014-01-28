$ ->

	window.submit = false

	
	
	$('#new-marker').on('ajax:success', (e, data, status, xhr)->
		infowindow = new google.maps.InfoWindow({content: data.markerInfoHtml})
		marker = window.currentMarker
		google.maps.event.addListener(marker, 'click', (event) ->
			infowindow.open(handler.map.serviceObject, marker)
	  )

		window.submit = true
		$('#newPinModal').modal('hide')
	)	
	
	$('#new-marker').on('ajax:error', (e, data, status, xhr)->
			
		clearMarkerFrom()

		$.each(data.responseJSON, (name, error) ->
			name = "marker[#{name}]"
			parent = $('#new-marker').find('[name="'+name+'"]').parents('.form-group').addClass('has-error')
			$('<span>').addClass('help-block').html(error).appendTo(parent.find('.controls'))
		)

		window.submit = false		
	)	

	$('#newPinModal').on('hidden.bs.modal', -> 
	
		if !window.submit
			window.currentMarker.setMap(null)

		window.submit = false	
	)

	if typeof google != 'undefined'
		google.maps.event.addListener(handler.map.serviceObject, 'click', (event) ->
			activeTab = $("ul#map-menu li.active a").data('name')
			if activeTab != null and activeTab != 'home' 
				placeMarker(event.latLng)

		)


	$('#map-menu a').click ->
		$('#marker_pin_type').val($(this).data('marker-id'))
			

	window.markerModal = (id) ->
		$.get("/markers/#{id}", (data) ->
			$('#markerModalBody').html(data)
			$('#markerModal').modal('show')			
		)

	clearMarkerFrom = ()-> 
		$('#new-marker').find('.form-group').each ->
			$(this).removeClass('has-error')
			$(this).find('.controls span').remove()
		$("#new-marker input[type=text], textarea").val("");


	placeMarker = (location)->
		clickedLocation = new google.maps.LatLng(location)
		window.currentMarker = new google.maps.Marker({ position: location, map: handler.map.serviceObject})


		clearMarkerFrom()
		$('#marker_latitude').val(location.lat())
		$('#marker_longitude').val(location.lng())
		$('#newPinModal').modal('show')

		
		#handler.map.serviceObject.setCenter(location);
	
class Users::MapsController < ApplicationController

	def index
		@markers = Marker.where('privacy = ? or user_id = ?', Marker::PRIVACY[:public], current_user)

		@hash = Gmaps4rails.build_markers(@markers) do |marker, u|
		  u.lat marker.latitude
		  u.lng marker.longitude
		  u.infowindow Users::MapsHelper.prepareMarkerInfoHtml(marker)
		end

	end

end
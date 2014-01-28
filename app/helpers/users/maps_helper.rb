module Users::MapsHelper

	def self.prepareMarkerInfoHtml(marker)
		"<strong>category:</strong> #{marker.getType}
		<div class='marker-desc'>#{marker.description}</div>
		<a href='javascript:void(0)' data-id='#{marker.id}' class='marker-modal' onclick='markerModal(#{marker.id})'>read more</a>"
	end

end
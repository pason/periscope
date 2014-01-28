class Users::MarkersController < ApplicationController

	def show
		@marker = Marker.find(params[:id])

		respond_to do |format|
		  format.html { render :layout => false } 
		end

	end


	def create
		@marker = Marker.new(marker_params)
		@marker.user = current_user

		respond_to do |format|
			if @marker.save
				format.json { render json: {marker: @marker, markerInfoHtml: Users::MapsHelper.prepareMarkerInfoHtml(@marker)}}
			else
				format.json { render json: @marker.errors, status: :unprocessable_entity }
			end
    end
	end

	private

	  def marker_params
	    params.require(:marker).permit(:description, :pin_type, :privacy, :latitude, :longitude)
	  end

end

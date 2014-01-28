class Marker < ActiveRecord::Base
  
	PRIVACY = {:public => 1, :friends => 2, :private => 3}
	TYPE = {:anchorage => 1, :restaurant => 2, :bar => 3, :shop => 4, :laundry => 5, :other => 6  }

  validates_presence_of :description

  belongs_to :user
 	

  #Get Marker type by key
  def getType
  	Marker::TYPE.key(self.pin_type)
  end

end
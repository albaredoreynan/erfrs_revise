class Cgdp < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
	STATUS = %w{Draft Final}
end

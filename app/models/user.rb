class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subprojects

  [SuperUser].each do |role|
    define_method("#{role.name.underscore}?") do
      type == role.name
    end
  end
  
  

end

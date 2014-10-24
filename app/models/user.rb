class User < ActiveRecord::Base
  # include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller.current_user }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :subprojects
  belongs_to :role
  belongs_to :region
  belongs_to :municipality
  belongs_to :barangay

  [SuperUser].each do |role|
    define_method("#{role.name.underscore}?") do
      type == role.name
    end
  end

  def is_regional_or_admin?
    role.name == 'Regional Admin' || role.name == 'Admin' || role.name == 'National'
  end  

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_barangay_or_public?
    role.name == 'Barangay' || role.name == 'Public'
  end  
end

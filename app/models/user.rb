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

  scope :municipality_id, -> id { where(municipality_id: id).order(:name) }
  scope :region_id, -> region_id { includes(municipality: :province).where('provinces.region_id' => region_id)}
  scope :province_id, -> id { joins(:municipality).where('municipalities.province_id' => id) }
  scope :with_id,     -> id { where id: id }
  scope :username, -> username {where("users.username" => username)}
  scope :email, -> email {where("users.email" => email)}


  [SuperUser].each do |role|
    define_method("#{role.name.underscore}?") do
      type == role.name
    end
  end

  def is_regional_or_admin?
    role.name == 'Regional Admin' || role.name == 'Admin' || role.name == 'National'
  end

  def is_admin?
    role.name == 'Admin' || role.name == 'National'
  end  

  def full_name
    "#{first_name} #{last_name}"
  end

  def is_barangay_or_public?
    role.name == 'Barangay' || role.name == 'Public'
  end  

  def is_regional_level?
    role.name == 'Regional Admin' || role.name == 'Region'
  end
end

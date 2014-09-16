class User < ActiveRecord::Base
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

  def full_name
    "#{first_name} #{last_name}"
  end
end

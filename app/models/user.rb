class User < ApplicationRecord

  # PeterGate Roles: the :user role is added by default
  # The multiple option can be set true if users have multiple roles

  petergate(roles: [:site_admin, :teacher, :tenant_admin, :tenant_member], multiple: false)

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :first_name, :last_name

  has_many :blogs
  has_many :comments, dependent: :destroy

  def full_name
    "#{first_name} #{last_name}"
  end
end

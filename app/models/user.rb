class User
  include MongoMapper::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  include Canable::Cans
  key :name, String
  key :groups, Array

  timestamps!

  def full_name
    name || email
  end

  def admin?
    groups.include?('admin')
  end
end

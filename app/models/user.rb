class User
  include MongoMapper::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  include Canable::Cans
  plugin Noodall::Tagging

  key :name, String
  timestamps!

  alias_attribute :groups, :tags
  alias_attribute :group_list, :tag_list

  def full_name
    name || email
  end

  def admin?
    tags.include?('admin')
  end

end

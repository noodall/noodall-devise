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

  # Make emails for login case insensitive
  def self.find_for_authentication(conditions)
    conditions[:email] = /^#{conditions[:email].strip}$/i
    super(conditions)
  end

protected
  before_validation :clean_email
  def clean_email
    self.email = self.email.to_s.downcase.strip
  end

  def self.groups
    (self.tag_cloud + ['admin']).uniq
  end

end

class User
  include MongoMapper::Document
  include Canable::Cans
  plugin Noodall::Tagging

  key :name, String
  key :email, String
  key :permalink, String, :required => true
  key :bio, String
  key :remember_created_at, DateTime
  timestamps!

  alias_method :groups=, :tags=
  alias_method :groups, :tags
  alias_method :group_list=, :tag_list=
  alias_method :group_list, :tag_list

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable


  #-- Dragonfly -----------
  extend Dragonfly::ActiveModelExtensions
  register_dragonfly_app(:image_accessor, Dragonfly::App[:noodall_assets])

  image_accessor :avatar

  key :avatar_uid, String #For dragonfly file uid
  key :avatar_name, String
  key :avatar_ext, String
  key :avatar_size, Integer
  key :avatar_mime_type, String
  #------------------------

  cattr_accessor :editor_groups

  def full_name
    name || email
  end

  def admin?
    tags.include?('admin')
  end

  def editor?
    return true if self.class.editor_groups.blank?
    (self.class.editor_groups & tags).size > 0
  end

  def web_image_extension
    # If the extension id anything other than a png or gif then it should be a jpg
    case avatar_ext
    when 'png', 'gif'
      avatar_ext
    else
      'jpg'
    end.to_sym
  end

protected
  before_validation :clean_email
  def clean_email
    self.email = self.email.to_s.downcase.strip
  end

  def self.groups
    (self.tag_cloud.map(&:name) + ['admin']).uniq.sort
  end

  before_validation :set_permalink
  def set_permalink
    self.permalink = self.name.to_s.parameterize
  end
end

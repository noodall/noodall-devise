module Admin::UsersHelper
  include SortableTable::App::Helpers::ApplicationHelper

  def password_label
    text = 'Password'
    if User.respond_to? :password_length and User.password_length.kind_of? Range
      text += " (must be between #{User.password_length.first} and #{User.password_length.last} characters long)"
    end
    return text
  end
end

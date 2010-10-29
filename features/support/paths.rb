module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the sign in page/
      new_user_session_path
    when /the users admin page/
      admin_users_path
    end
  end
end

World(NavigationHelpers)

require 'noodall/permalinks'

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
    else
      begin
        page_name =~ /the (.*) page/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue Object => e
        raise "Can't find a mapping from \"#{page_name}\" to a path.\n" +
          "Please add one to #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
World(Noodall::Permalinks)

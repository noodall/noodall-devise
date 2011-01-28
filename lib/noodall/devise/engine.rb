module Noodall
  module Devise
    class Engine < Rails::Engine
      initializer "set menu" do |app|
        Noodall::UI.menu_items['Users'] = :admin_users_path
      end

      initializer "groups method" do |app|
        ActiveSupport.on_load(:action_controller) do
          include UserGroups
        end
      end
    end

    module UserGroups
      def user_groups
        User.groups
      end
    end
  end
end

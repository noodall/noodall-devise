module Noodall
  module Devise
    class Engine < Rails::Engine
      initializer "set menu" do |app|
        Noodall::UI.menu_items['Users'] = :admin_users_path
      end
    end
  end
end

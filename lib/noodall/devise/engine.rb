module Noodall
  module Devise
    class Engine < Rails::Engine
      initializer "static assets" do |app|
        Noodall::UI.menu_items['Users'] = :admin_users_path
      end
    end
  end
end

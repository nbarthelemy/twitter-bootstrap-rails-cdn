module TwitterBootstrap
  module Rails
    module Cdn
      class Railtie < ::Rails::Railtie
        initializer 'twitter_bootstrap_rails_cdn.action_view' do |app|
          ActiveSupport.on_load(:action_view) do
            include TwitterBootstrap::Rails::Cdn::ActionViewExtensions
          end
        end
      end
    end
  end
end

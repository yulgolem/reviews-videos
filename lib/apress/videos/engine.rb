# coding: utf-8
require 'rails'

module Apress
  module Videos
    class Engine < ::Rails::Engine
      config.autoload_paths += Dir["#{config.root}/lib"]
      config.i18n.load_path += Dir[config.root.join('locales', '*.{rb,yml}').to_s]

      initializer :apress_videos_factories, :after => "factory_girl.set_factory_paths" do |app|
        if defined?(FactoryGirl)
          FactoryGirl.definition_file_paths.unshift root.join('spec', 'factories')
        end
      end

      initializer :define_apress_videos_migration_paths do |app|
        unless app.root.to_s.match root.to_s
          app.config.paths['db/migrate'].concat(config.paths['db/migrate'].expanded)
        end
      end
    end
  end
end

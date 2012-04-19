module Requirejs
  module Controllers
    module Rails
      class Engine < ::Rails::Engine
        config.before_initialize do |app|
          js_path = app.paths['app/assets'].to_a.select {|p| p =~ /javascripts/}.first

          # find all controller modules and strip the filext
          modules = Dir[File.join(js_path, 'controllers/**/*')].select do |fn|
            File.file?(fn)
          end.map do |fn|
            {'name' => fn.sub(js_path + '/', '').sub(/\.js.*$/, '')}
          end

          config.requirejs.user_config['modules'] = modules
        end
      end
    end
  end
end

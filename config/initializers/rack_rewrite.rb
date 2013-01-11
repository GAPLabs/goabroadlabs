GoAroadLabs::Application.config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
    r301 %r{.*}, 'http://www.gaplabs.ph$&', :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] == 'gaplabs.ph'
    }
end
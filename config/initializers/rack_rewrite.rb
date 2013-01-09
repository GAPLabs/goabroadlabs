GoAroadLabs::Application.config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
    r301 %r{.*}, 'http://www.goabroadlabs.ph$&', :if => Proc.new {|rack_env|
    rack_env['SERVER_NAME'] == 'goabroadlabs.ph'
    }
end
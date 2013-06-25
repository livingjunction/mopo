Mopo::Application.configure do  
  # Note: Hashie is a gem dependency
  config.secrets = Hashie::Mash.new(YAML.load_file(Rails.root.join('config', 'secrets.yml'))[Rails.env.to_s])
end 
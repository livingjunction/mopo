require 'localeapp/rails'

Localeapp.configure do |config|
  config.api_key = 'UAqsPV9wXtj1ksRtDJyKbRsHu3RRhTujFkQwrabIMz59oIFkje'
  
  #By default, your Ruby on Rails application will only send newly created translation keys when running in the development environment. 
  #When a page is refreshed locally, any unpopulated keys are sent to the app's corresponding localeapp.com project. 
  #disable it
  config.sending_environments = []
  
  #Rails' development environment also polls for translations from localeapp.com by default on every request.
  #disable it
  config.polling_environments = []
end

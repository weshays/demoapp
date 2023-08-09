DEMOAPP_NOREPLY_EMAIL = 'weshays@gmail.com'

DEMOAPP_BASE_URL = if Rails.env.production?
                       'https://app.demoapp.dev'
                     elsif Rails.env.staging?
                       'https://app-staging.demoapp.dev'
                     elsif Rails.env.test?
                       'http://the_reset_url'
                     else
                       'http://localhost:8000'
                     end

DEMOAPP_BASE_API_PROTOCOL = (Rails.env.production? || Rails.env.staging?) ? 'https' : 'http'
DEMOAPP_BASE_API_HOST = if Rails.env.production?
                            'api.demoapp.dev'
                          elsif Rails.env.staging?
                            'app-staging.demoapp.dev'
                          elsif Rails.env.test?
                            'the_reset_url'
                          else
                            'localhost:3000'
                          end
DEMOAPP_BASE_API_URL = "#{DEMOAPP_BASE_API_PROTOCOL}://#{DEMOAPP_BASE_API_HOST}"

SimpleCov.minimum_coverage 100
SimpleCov.start 'rails' do
  # Remove default groups
  groups.delete('Channels')
  groups.delete('Libraries')
  groups.delete('Mailers')
  groups.delete('Ungrouped')

  add_group 'Serializers', 'app/serializers'
  add_group 'Services', 'app/services'
  add_group 'Model Concerns', 'app/models/concerns'
  add_group 'Controller Concerns', 'app/controllers/concerns'

  # Just ignore these ones.
  add_filter 'concerns/bugsnag_notifications.rb'
  add_filter 'concerns/file_download.rb'
  add_filter 'app/channels'
  add_filter 'app/mailers'
end

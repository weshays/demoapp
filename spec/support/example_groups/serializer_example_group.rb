# Largely borrowed from:
# http://benediktdeicke.com/2013/01/custom-rspec-example-groups/
require 'active_support'

module SerializerExampleGroup
  extend ActiveSupport::Concern

  RSpec.configure do |config|
    config.include self, type: :serializer, file_path: %r{spec\/serializers}
  end

  included do
    metadata[:type] = :serializer

    let(:resource_key) { nil }
    let(:resource) { nil }
    let(:resource_options) { {} }
    let(:serializer_options) { {} }
    let(:serializer_name) { nil }

    subject { serialize(resource, resource_options, serializer_name)[resource_key] }
    specify { expect(subject.keys.sort).to eq(expected_fields) }
  end

  def serialize(obj, opts={}, serializer_name)
    serializer_name ||= obj.class.name
    serializer_class = opts.delete(:serializer_class) || "#{serializer_name}Serializer".constantize
    serializer = serializer_class.send(:new, obj, serializer_options)
    adapter = ActiveModelSerializers::Adapter.create(serializer, opts)
    adapter.as_json
  end
end

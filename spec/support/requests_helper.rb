module Requests
  # Disable Flash.now from being cleared out.
  module DisableFlashSweeping
    def sweep; end
  end

  module JsonHelpers
    def json
      invalid_json unless valid_json?
      parse_json
    end

    private

    def parse_json
      @json = subject_body || response_body1 || response_body2
    end

    def subject_body
      return unless defined? subject
      return unless subject.respond_to? :body
      JSON.parse(subject.body)
    end

    def response_body1
      return unless defined? response
      return unless response.respond_to? :body
      JSON.parse(response.body)
    end

    def response_body2
      return if response_body.nil?
      JSON.parse(response_body)
    end

    def invalid_json
      raise 'Unable to parse JSON response \
        - please ensure your spec is correctly formed!'
    end

    def valid_json?
      return true unless subject.nil?
      return true unless response.nil?
      return true unless response_body.nil?
      return true unless subject.try(:body)
      return true unless response.try(:body)
      false
    end
  end
end

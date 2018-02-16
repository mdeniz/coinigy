module Coinigy
  # Represents the response from the API
  class Response
    def initialize(body)
      @json = Yajl::Parser.parse(body)
    end

    def error?
      @json.is_a?(Hash) && !@json['err_num'].nil?
    end

    def error
      return nil unless error?
      number, method_id, instance = @json['err_num'].split('-')
      {
        number: number,
        method_id: method_id,
        instance: instance,
        message: @json['err_msg']
      }
    end

    def data
      return nil if error?
      @json['data']
    end

    def notifications
      return nil if error?
      @json['notifications']
    end

    def to_json
      @json
    end
  end
end

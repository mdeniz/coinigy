module Coinigy
  # Base for models
  class Model
    include ActiveModel::Model

    attr_reader :errors

    def initialize(attributes = {})
      super
      @errors = []
    end

    def attributes
      {}
    end

    def errors?
      @errors.present?
    end

    def save
      response = save_to_api(attributes)
      add_error(response.error) if response.error?
      !response.error?
    rescue Exception => e
      false
    end

    private

    def save_to_api(_data)
      Coinigy::Response.new({'err_num' => 999})
    end

    def add_error(new_error)
      @errors << new_error
    end
  end
end

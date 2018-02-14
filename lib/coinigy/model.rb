module Coinigy
  # Base for models
  class Model
    include ActiveModel::Model

    attr_reader :errors

    def initialize
      super
      @errors = []
    end

    def errors?
      @errors.present?
    end

    private

    def add_error(new_error)
      @errors << new_error
    end
  end
end

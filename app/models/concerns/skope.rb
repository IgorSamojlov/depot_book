require 'active_support/concern'

  module Skope
    extend ActiveSupport::Concern

    included do
      define_presence_scopes
    end

    module ClassMethods

      def define_presence_scopes
        scope :l_name, -> { where("name.count != 0") }
      end

    end
end

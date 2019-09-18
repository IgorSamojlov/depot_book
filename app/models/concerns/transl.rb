require 'active_support/concern'

module humanise_method
  extend ActiveSupport::Concern

  included do
    add_methods
  end

  module ClassMethods
    def add_methods
      self.column_names.each do |name|
        self.class_eval %Q{
          def #{name}_humanise?
            I18n.t "activerecord.attribute_values.order.methods#{name}"
        }
      end
    end
  end
end

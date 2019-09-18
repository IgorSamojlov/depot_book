module HumaniseMethod
  def add_methods(*methods)
    methods.each do |method|
      self.class_eval %Q{
        def #{method}_value_humanise
          value = public_send :#{method}
          I18n.t value, scope: [:activerecord, self.class.name.underscore,
            :hum_methods, "#{method}"], default: value.to_s
        end
      }
    end
  end
end

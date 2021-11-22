module Accessor

  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      var_name_history = []
      define_method(name) { instance_variable_get(var_name) }
      define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)
        if var_name_history.last != value
          var_name_history.push(value)
        end
      end
      define_method("#{name}_history".to_sym) { puts var_name_history }
    end
  end

  def strong_attr_accessor(attr_name, class_name)
    var_attr_name = "@#{attr_name}".to_sym
    define_method(attr_name) { instance_variable_get(var_attr_name) }
    define_method("#{attr_name}=".to_sym) do |value|
      raise "Wrong type" if  value.class != class_name  
      instance_variable_set(var_attr_name, value)
      end
  end
end
module Validate


  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods

    def all_validation
      @all_validation ||= []
    end

    def validate(name, valid_type, optional = nil)
      instance_name = "@#{name}".to_sym
      all_validation << { 'instance' => instance_name, 'type' => valid_type, 'optional' => optional }
    end

  end

  module InstanceMethods

    def presence(name, param)
      instance_name = instance_variable_get(name)
      raise "#{name} - Имя не может быть нулем или пустым" if instance_name.empty? or instance_name.nil?
    end

    def format(name, regexp)
      instance_name = instance_variable_get(name)
      raise "Неправильный формат #{name}" if instance_name !~ regexp
    end

    def type(name,type)
      instance_name = instance_variable_get(name)
      raise "Неверный тип #{name}" if instance_name.class != type
    end

    def validate!
      self.class.all_validation.each do |validate|
        send(validate['type'].to_sym, validate['instance'], validate['optional'])
      end
    end

    def valid?
      validate!
    rescue
      false
    end
  end

  end


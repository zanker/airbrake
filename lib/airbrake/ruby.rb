require 'airbrake'

module Airbrake
  module Ruby
   module ClassMethods
      def self.extended(base)
        base.instance_eval do
          alias :original_new :new

          def new(*args)
            # Airbrake.notify_or_ignore(self)
            original_new(*args)
          end
        end
      end

    end

    module InstanceMethods
      def self.included(base)
        base.class_eval do
          alias :original_exception :exception

          def exception(*args)
            # Airbrake.notify_or_ignore(self)
            original_exception(*args)
          end
        end
      end
    end

    def self.included(base)
      base.send(:include, InstanceMethods)
      base.send(:extend, ClassMethods)
    end
  end
end

Exception.send(:include,Airbrake::Ruby)

jfas

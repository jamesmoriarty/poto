module Poto
  module FileRepository
    class Proxy
      module DSL
        module ClassMethods
          def option(name)
            define_method(name) do |value|
              tap do
                options[name] = value
              end
            end
          end
        end

        def self.included(base)
          base.extend(ClassMethods)
        end

        def options
          @__options ||= {}
        end
      end
    end
  end
end

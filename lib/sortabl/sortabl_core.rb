module Sortabl
  module ActiveRecordExtensions
    module Sortabl

      extend ActiveSupport::Concern

      module ClassMethods

        def sortabl(parameter, mapping = {}, *args)
          unless args.empty?
            default = args[0][:default]
            only = args[0][:only]
            except = args[0][:except]
          end

          if only.present? && except.present?
            raise ArgumentError.new "Do not use 'only' and 'except' together!"
          end

          # Set default order attribute
          order_by_default = default.present? ? default : self.primary_key

          if parameter.blank?
            return order order_by_default
          end

          # Extract column name and direction from parameter
          column_name = parameter.to_s.gsub(/(_asc$|_desc$)/, '')
          direction = parameter.to_s.gsub(/^((?!desc$|asc$).)*/, '') || 'asc'

          return order order_by_default if column_name.blank? || direction.blank?
          column_name = column_name.to_sym
          direction = direction.to_sym

          return order order_by_default if only.present? && !only.include?(column_name)
          return order order_by_default if except.present? && except.include?(column_name)

          column_name = mapping[column_name.to_sym] || column_name
          if column_name.is_a? Symbol
            sort_column = {column_name.to_sym => direction.to_sym}
          else
            sort_column = "#{column_name} #{direction}"
          end

          order sort_column
        end
      end

    end
  end
end

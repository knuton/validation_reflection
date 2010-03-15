module ActiveRecordExtensions
  module RequirementInspection

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def check_validates_acceptance_of(reflection)
        !reflection.options[:allow_nil]
      end
      
      def check_validates_exclusion_of(reflection)
        !reflection.options[:allow_nil] && !reflection.options[:allow_blank]
      end

      def check_validates_format_of(reflection)
        !reflection.options[:allow_nil] && !reflection.options[:allow_blank]
      end

      def check_validates_inclusion_of(reflection)
        !reflection.options[:allow_nil] && !reflection.options[:allow_blank]
      end

      def check_validates_length_of(reflection)
        !reflection.options[:allow_nil] && !reflection.options[:allow_blank]
      end

      def check_validates_numericality_of(reflection)
        !reflection.options[:allow_nil] && !reflection.options[:allow_blank]
      end

      def check_validates_size_of(reflection)
        !reflection.options[:allow_nil] && !reflection.options[:allow_blank]
      end

      def check_validates_presence_of(reflection)
        true
      end

      def check_validates_uniqueness_of(reflection)
        !reflection.options[:allow_nil] && !reflection.options[:allow_blank]
      end

      def requires?(method)
        macro_reflections = reflect_on_validations_for(method)
        
        macro_reflections.each do |reflection|
          return true if self.send("check_#{reflection.macro}", reflection)
        end
        return false
      end
    end # end ClassMethods
  end
end

ActiveRecord::Base.class_eval do
  include ::ActiveRecordExtensions::RequirementInspection
end

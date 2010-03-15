# encoding: utf-8
#--
# Copyright (c) 2010, Johannes Emerich, johannes@emerich.de
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++
module ActiveRecordExtensions
  module RequirementInspection

    def self.included(base)
      base.extend(ClassMethods)
    end
    
    # These methods are available in any ActiveRecord descendant, but are meant
    # to be used through the requires?(attribute_name) method.
    # A rework to include special conditions should be considered if used for
    # projects with more complex validations.
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
      
      # Returns a boolean value, "answering" the question, whether a certain
      # attribute is required or not, i.e. if the record will be valid without
      # it.
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

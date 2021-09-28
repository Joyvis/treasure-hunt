# frozen_string_literal: true

module InteractorValidations
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def requires(*attributes)
      before do
        attributes.each do |attribute|
          unless context.public_send(attribute).present?
            context.fail!(error: "Required attribute #{attribute} is missing")
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe InteractorValidations do
  class ValidationsTest
    include Interactor
    include InteractorValidations

    delegate :email, to: :context
    requires :email
  end

  subject { ValidationsTest.call(email: email) }

  context 'when a required attribute is present' do
    let(:email) { 'abc@abc.com' }

    it 'responds with a success response' do
      expect(subject.success?).to be_truthy
    end
  end

  context 'when a required attribute is missing' do
    let(:email) { nil }

    it 'responds with a fail response' do
      expect(subject.success?).to be_falsey
    end
  end
end

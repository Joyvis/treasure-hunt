# frozen_string_literal: true

require 'rails_helper'

describe Treasures::CalculateDistanceSteps::LimitUserRequests do
  let(:email) { 'test@test.com' }

  subject { described_class.call(email: email) }

  context 'when exist less than 20 requests per hour for a given email' do
    it 'returns a success response' do
      expect(subject.success?).to be_truthy
    end
  end

  context 'when exist 20 or more request per hour for a given email' do
    before do
      create_list(:user_request, 21, email: email)
    end

    it 'returns a fail response' do
      expect(subject.success?).to be_falsey
    end
  end
end


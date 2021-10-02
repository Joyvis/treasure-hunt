# frozen_string_literal: true

require 'rails_helper'

describe Treasures::CalculateDistanceSteps::SaveUserRequest do
  let(:user_request_attrs) { attributes_for(:user_request) }

  subject { described_class.call(user_request_attrs) }

  it 'returns a success response' do
    expect(subject.success?).to be_truthy
  end

  it 'returns a instance of user request' do
    expect(subject.user_request).to be_an UserRequest
    expect(UserRequest.count).to eq 1
  end
end

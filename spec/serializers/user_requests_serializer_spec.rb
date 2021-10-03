# frozen_string_literal: true

require 'rails_helper'

describe UserRequestSerializer, type: :serializer do
  let(:user_request) { create(:user_request) }

  subject { described_class.new(user_request).serializable_hash }

  describe 'checking attributes presence' do
    it { is_expected.to include(:email) }
    it { is_expected.to include(:current_location) }
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe Treasures::CalculateDistanceSteps::SendEmailTreasureFound do
  before do
    create_list(:user_request, 10, email: email, distance: 0)
    create_list(:user_request, 10, email: 'other@test.com', distance: 0)
    create_list(:user_request, 10, email: email, distance: 10)
    create_list(:user_request, 10, email: 'other@test.com', distance: 10)
  end

  let(:email) { 'test@test.com' }

  subject { described_class.call(distance: distance, email: email) }

  context 'when distance is zero' do
    let(:distance) { 0 }

    it 'returns a success response' do
      expect(subject.success?).to be_truthy
    end

    it 'returns a distinct treasure finder counter' do
      expect(subject.treasure_finder_count).to eq(3)
    end

    it 'sends an email with treasure position' do
      expect { subject }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context 'when distance is not zero' do
    let(:distance) { 1 }

    it 'does not send an email message' do
      expect { subject }
        .to change { ActionMailer::Base.deliveries.count }.by(0)
    end
  end
end

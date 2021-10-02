# frozen_string_literal: true

require 'rails_helper'

describe Treasures::CalculateDistanceSteps::SendEmailTreasurePosition do
  let(:email) { 'test@test.com' }
  subject { described_class.call(email: email, distance: distance) }

  context 'when distance is lesser or equal than 5 and greater than 0' do
    let(:distance) { rand(1..5) }

    it 'sends an email with exact position of treasure' do
      expect { subject }
        .to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  context 'when distance is greater than 5' do
    let(:distance) { 6 }

    it 'does not send an email with exact position of treasure' do
      expect { subject }
        .to change { ActionMailer::Base.deliveries.count }.by(0)
    end
  end

  context 'when distance is not greater than 0' do
    let(:distance) { 0 }

    it 'does not send an email with exact position of treasure' do
      expect { subject }
        .to change { ActionMailer::Base.deliveries.count }.by(0)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

describe UserRequests::List do
  before do
    create_list(:user_request, 10, created_at: '2021-01-01 20:20:00'.to_time)
    create_list(:user_request, 10)
    create_list(:user_request, 2, distance: 1)
  end

  let(:start_time) { Time.now - 1.hour }
  let(:end_time) { Time.now }
  let(:radius) { nil }

  subject do
    described_class.call(
      start_time: start_time,
      end_time: end_time,
      radius: radius
    )
  end

  it 'returns a success response' do
    expect(subject.success?).to be_truthy
  end

  context 'when radius is present' do
    let(:radius) { 1 }

    it 'returns requests between start and end time' do
      expect(subject.requests.count).to eq(2)
    end
  end

  context 'when radius is not present' do
    it 'returns requests between start and end time' do
      expect(subject.requests.count).to eq(12)
    end
  end
end

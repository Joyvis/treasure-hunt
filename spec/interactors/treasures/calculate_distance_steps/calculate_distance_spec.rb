# frozen_string_literal: true

require 'rails_helper'

describe Treasures::CalculateDistanceSteps::CalculateDistance do
  subject do
    described_class.call(email: email, longitude: longitude, latitude: latitude)
  end

  context 'when all required attributes are present' do
    let(:email) { 'test@test.com' }
    let(:latitude) { '50.051227 N' }
    let(:longitude) { '19.945704 E' }

    it 'returns a success response' do
      expect(subject.success?).to be_truthy
    end

    context 'and coordinates are the same than the treasure' do
      it 'returns distance equal 0' do
        expect(subject.distance).to be_zero
      end
    end

    context 'and coordinates are different than the treasure' do
      let(:latitude) { '50.051227 S' }
      let(:longitude) { '19.945704 W' }

      it 'returns distance different than 0' do
        expect(subject.distance).not_to be_zero
      end

      context 'and using real coordinates' do
        let(:latitude) { '49.051227 N' }
        let(:longitude) { '18.945704 E' }

        it 'returns distance equal 132543.18' do
          expect(subject.distance).to eq 132543.18
        end
      end
    end
  end

  context 'when a required attribute is not present' do
    let(:email) { 'test@test.com' }
    let(:latitude) { '50.051227 N' }
    let(:longitude) { '19.945704 E' }

    context 'and email is not present' do
      let(:email) { nil }

      it 'returns a fail response' do
        expect(subject.success?).to be_falsey
      end

      it 'returns a email missing error message' do
        expect(subject.error).to eq 'Required attribute email is missing'
      end
    end

    context 'and latitude is not present' do
      let(:latitude) { nil }

      it 'returns a fail response' do
        expect(subject.success?).to be_falsey
      end

      it 'returns a latitude missing error message' do
        expect(subject.error).to eq 'Required attribute latitude is missing'
      end
    end

    context 'and longitude is not present' do
      let(:longitude) { nil }

      it 'returns a fail response' do
        expect(subject.success?).to be_falsey
      end

      it 'returns a longitude missing error message' do
        expect(subject.error).to eq 'Required attribute longitude is missing'
      end
    end
  end
end

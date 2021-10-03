require 'rails_helper'

describe "TreasureHunts", type: :request do
  let(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }

  describe "POST /treasure_hunt" do
    before { post '/treasure_hunt', params: params }

    context 'with valid parameters' do
      let(:params) do
        {
          email: 'test@test.com',
          current_location: [
            '51.051227 N',
            '20.945704 E'
          ]
        }
      end

      it 'returns :ok http status ' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a no error response' do
        expect(parsed_response[:status]).to eq('ok')
        expect(parsed_response[:distance]).to be_present
        expect(parsed_response[:error]).not_to be_present
      end
    end

    context 'with invalid parameters' do
      let(:params) { nil }

      it 'returns a :bad_request status' do
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns a error response' do
        expect(parsed_response[:status]).to eq('error')
        expect(parsed_response[:distance]).to eq -1
        expect(parsed_response[:error]).to be_present
      end
    end
  end

  describe 'GET /analytics' do
    let(:created_time) do
      '2021-01-01 20:20:00 UTC'.
        to_datetime
    end

    before do
      create_list(:user_request, 10, distance: 20, created_at: created_time)
      create_list(:user_request, 2, distance: 2, created_at: created_time)

      get '/analytics', params: params
    end

    context 'with valid parameters' do
      let(:params) do
        {
          start_time: created_time - 2.hour,
          end_time: created_time
        }
      end

      it 'returns a :ok status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns all requests created last 2 hours' do
        expect(parsed_response[:status]).to eq('ok')
        expect(parsed_response[:requests].count).to eq(12)
        expect(parsed_response[:requests].first.keys)
          .to include(:email)
        expect(parsed_response[:requests].first.keys)
          .to include(:current_location)
      end

      context 'and radius is also present' do
        let(:params) do
          {
            start_time: created_time - 2.hour,
            end_time: created_time,
            radius: 2
          }
        end

        it 'returns all requests created last hour and closer than 2 meters' do
          expect(parsed_response[:status]).to eq('ok')
          expect(parsed_response[:requests].count).to eq(2)
          expect(parsed_response[:requests].first.keys)
            .to include(:email)
          expect(parsed_response[:requests].first.keys)
            .to include(:current_location)
        end
      end
    end

    context 'with invalid parameters' do
    end
  end
end

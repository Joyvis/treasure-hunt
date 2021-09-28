require 'rails_helper'

describe "TreasureHunts", type: :request do
  describe "POST /treasure_hunt" do
    before { post '/treasure_hunt', params: params }

    let(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }

    context 'with valid parameters' do
      let(:params) do
        {
          email: 'test@test.com',
          current_location: {
            longitude: '50.051227 N',
            latitude: '19.945704 E'
          }
        }
      end

      it 'returns :ok http status ' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a no error response' do
        expect(parsed_response[:status]).to eq('ok')
        expect(parsed_response[:distance]).to be_present
        expect(parsed_response[:error]).to be_nil
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
end

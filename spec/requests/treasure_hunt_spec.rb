require 'rails_helper'

describe "TreasureHunts", type: :request do
  describe "POST /treasure_hunt" do
    before { post '/treasure_hunt' }

    let(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }

    context 'with valid parameters' do
      it 'returns :ok http status ' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns a no error response' do
        expect(parsed_response[:status]).to eq('ok')
        expect(parsed_response[:distance]).to be_present
      end
    end

    context 'with invalid parameters' do
    end
  end
end

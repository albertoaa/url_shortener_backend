require 'rails_helper'

RSpec.describe 'Links API', type: :request do
  let!(:links) { create_list(:link, 10) }
  let(:link_id) { link.first.id }

  describe 'all' do
    before { get '/api/v1/links' }

    it 'returns all the links' do
      expect(links).not_to be_empty
      expect(links.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'store link' do
    # valid payload
    let(:valid_attributes) { {
      url: Faker::Internet.url,
      shortened: Faker::TvShows::FamilyGuy.character
    } }

    context 'when the request is valid' do
      before { post '/api/v1/links', params: valid_attributes }

      it 'stores a link' do
        expect(json['url']).to eq(valid_attributes[:url])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/links', params: { url: valid_attributes[:url] } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"shortened\":[\"can't be blank\"]}")
      end
    end
  end
end
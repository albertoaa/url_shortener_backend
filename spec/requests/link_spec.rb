require 'rails_helper'

RSpec.describe 'Links API', type: :request do
  let!(:links) { create_list(:link, 10) }

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

  describe 'count' do
    before { get '/api/v1/count' }

    it 'counts all the links' do
      expect(json).to eq(10)
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

    context 'whe there is only url' do
      before { post '/api/v1/links', params: { url: valid_attributes[:url] } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"shortened\":[\"can't be blank\"]}")
      end
    end

    context 'when there is only shortened' do
      before { post '/api/v1/links', params: { shortened: valid_attributes[:shortened] } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"url\":[\"can't be blank\"]}")
      end
    end

    context 'when there is the same url' do

      before { post '/api/v1/links', params: {
        url: valid_attributes[:url],
        shortened: Faker::Name.unique.name
      } }
      before { post '/api/v1/links', params: {
        url: valid_attributes[:url],
        shortened: Faker::Name.unique.name
      } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"url\":[\"has already been taken\"]}")
      end
    end

    context 'when there is the same shortened' do

      before { post '/api/v1/links', params: {
        url: Faker::Internet.unique.url,
        shortened: valid_attributes[:shortened]
      } }
      before { post '/api/v1/links', params: {
        url: Faker::Internet.unique.url,
        shortened: valid_attributes[:shortened]
      } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match("{\"shortened\":[\"has already been taken\"]}")
      end
    end
  end

  describe 'get' do
    # valid payload
    let(:valid_attributes) { {
      url: Faker::Internet.url,
      shortened: Faker::TvShows::FamilyGuy.character
    } }

    before { post '/api/v1/get', params: { url: valid_attributes[:url] }}

    context 'when there is a link' do
      before { post '/api/v1/links', params: valid_attributes }

      it 'returns shortened for it' do
        expect(json).not_to be_empty
        expect(json['shortened']).to eq(valid_attributes[:shortened])
      end
    end

    context 'when there is no link' do
      it 'returns nothing' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end
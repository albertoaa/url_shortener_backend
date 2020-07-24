require 'rails_helper'

RSpec.describe 'Links API', type: :request do
  let!(:links) { create_list(:link, 10) }

  describe 'all' do
    before { get api_v1_links_index_path }

    it 'returns all the links' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'count' do
    before { get api_v1_links_count_path }

    it 'counts all the links' do
      expect(json).to eq(10)
    end
  end

  describe 'get' do
    # valid payload
    let(:valid_attributes) { {
      url: Faker::Internet.url,
      shortened: Faker::Number.number
    } }

    context 'when there is a link' do
      before { post api_v1_links_store_path, params: valid_attributes }
      before { post api_v1_links_get_path, params: { url: valid_attributes[:url] }}

      it 'returns shortened for it' do
        expect(json).not_to be_empty
        expect(json['shortened']).to eq("#{request.base_url}/#{valid_attributes[:shortened]}")
      end
    end

    context 'when there is no link' do
      before { post api_v1_links_get_path, params: { url: valid_attributes[:url] }}

      it 'returns nothing' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'store' do
    # valid payload
    let(:valid_attributes) { {
      url: Faker::Internet.url,
      shortened: Faker::Number.number
    } }

    context 'when the request is valid' do
      before { post api_v1_links_store_path, params: valid_attributes }

      it 'stores a link' do
        expect(json['url']).to eq(valid_attributes[:url])
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end
end
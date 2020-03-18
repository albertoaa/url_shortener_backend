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
end
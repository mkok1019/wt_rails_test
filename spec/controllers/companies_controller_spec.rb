require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let!(:companies) { create_list :company, 5 }
  let(:company_id) { companies.first.id }

  describe 'GET /companies' do
    before { get :index }

    it 'return status 200' do
      expect(response).to have_http_status :ok
    end

    it 'return document types' do
      expect(json.size).to eq 5
    end
  end

  describe 'GET /companies/:id' do
    context 'when the record is exist' do
      before { get :show, id: company_id }

      it 'return status 200' do
        expect(response).to have_http_status :ok
      end

      it 'return document types' do
        expect(json['id']).to eq company_id
      end
    end

    context 'when the record is not exist' do
      let(:company_id) { 100 }
      before { get :show, id: company_id }

      it 'return status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'return a not found message' do
        expect(json).to match("Company doesn't exist")
      end
    end
  end

  describe 'POST /companies' do
    let(:valid_params) { { name: Faker::Company.name } }

    context 'when the request is valid' do
      before { post :create, params: valid_params }

      it 'create a company' do
        expect(json['name']).to eq(valid_params[:name])
      end

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  describe 'PUT /companies/:id' do
    let(:valid_params) { { id: company_id, name: Faker::Company.name } }

    context 'when the record is exist' do
      before { put :update, params: valid_params }

      it 'update the record' do
        expect(response.body).to be_empty
      end

      it 'return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /companies/:id' do
    before { delete :destroy, id: company_id }

    it 'return status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

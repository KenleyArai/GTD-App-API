require 'rails_helper'

RSpec.describe 'Actions API' do
    # Initialize the test data
    let!(:project) { create(:project) }
    let!(:actions) { create_list(:action, 20, project_id: project.id) }
    let(:project_id) { project.id }
    let(:id) { actions.first.id }

    # Test suite for GET /project/:project_id/actions
    describe 'GET /projects/:project_id/actions' do
        before { get "/actions/#{project_id}/actions" }

        context 'when project exists' do
        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end

        it 'returns all project actions' do
            expect(json.size).to eq(20)
        end
    end

    context 'when project does not exist' do
        let(:project_id) { 0 }

        it 'returns status code 404' do
            expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Project/)
        end
    end
  end

  # Test suite for GET /projects/:project_id/actions/:id
  describe 'GET /projects/:project_id/actions/:id' do
    before { get "/projects/#{project_id}/items/#{id}" }

    context 'when project action exists' do
        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end

        it 'returns the action' do
            expect(json['id']).to eq(id)
        end
    end

    context 'when project action does not exist' do
        let(:id) { 0 }

        it 'returns status code 404' do
            expect(response).to have_http_status(404)
        end

        it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Action/)
        end
    end
  end

  # Test suite for PUT /projects/:project_id/actions
  describe 'POST /projects/:project_id/actions' do
    let(:valid_attributes) { { name: 'Go shopping', done: false } }

    context 'when request attributes are valid' do
      before { post "/projects/#{project_id}/actions", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/projects/#{project_id}/actions", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  # Test suite for PUT /projects/:project_id/actions/:id
  describe 'PUT /projects/:project_id/actions/:id' do
    let(:valid_attributes) { { name: 'Apples' } }

    before { put "/projects/#{project_id}/actions/#{id}", params: valid_attributes }

    context 'when action exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the action' do
        updated_action= Action.find(id)
        expect(updated_action.title).to match(/Apples/)
      end
    end

    context 'when the action does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Action/)
      end
    end
  end

  # Test suite for DELETE /projects/:id
  describe 'DELETE /projects/:id' do
    before { delete "/projects/#{project_id}/actions/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
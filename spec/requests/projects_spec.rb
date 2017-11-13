require 'rails_helper'

RSpec.describe 'Projects API', type: :request do

    # Initialize test data
    let!(:project) { create(:project) }
    let!(:project_id) { project.id }
    let!(:actions) { create_list(:action, 20, project_id: project.id) }
    let(:action_id) { actions.first.id }

    # Test suite for GET /projects
    describe 'GET /projects' do
        before { get '/projects' }

        it 'returns projects' do
            expect(json).not_to be_empty
            expect(json.size).to eq(1)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end
    # Test suite for GET /projects/:id
    describe 'GET /projects/:id' do
        before { get "/projects/#{project_id}" }

        context 'when the record exists' do
            it 'returns the project' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(project_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do
            let(:project_id) { 100 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Project/)
            end
        end
    end
    # Test suite for POST /projects
    describe 'POST /projects' do
        let(:valid_attributes) { { title: 'Learn Ruby', created_by:'Bob' } }

        context 'when the request is valid' do
            before { post '/projects' , params: valid_attributes }

            it 'creates a project' do
                expect(json['title']).to eq('Learn Ruby')
                expect(json['created_by']).to eq('Bob')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before { post '/projects', params: {} }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                  .to match(/Validation failed: Title can't be blank/)
            end
        end
    end
    # Test suite for PUT /projects/:id
    describe 'PUT /projects/:id' do
        let(:valid_attributes) { { title: 'Chores' } }

        context 'when the record exists' do
            before { put "/projects/#{project_id}", params: valid_attributes }
      
            it 'updates the record' do
              expect(response.body).to be_empty
            end
      
            it 'returns status code 204' do
              expect(response).to have_http_status(204)
            end
        end
    end
    # Test suite for DELETE /projects/:id
    describe 'DELETE /projects/:id' do
        before { delete "/projects/#{project_id}" }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end
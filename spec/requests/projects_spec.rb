require 'rails_helper'

RSpec.describe 'Projects API', type: :request do

    # Initialize test data
    let(:user) { create(:user) }
    let!(:projects) { create_list(:project, 20, created_by: user.id) }
    let(:project_id) { projects.first.id }
    # authorize request
    let(:headers) { valid_headers }

    # Test suite for GET /projects
    describe 'GET /projects' do
        before { get '/projects', params: {}, headers: headers }

        it 'returns projects' do
            expect(json).not_to be_empty
            expect(json.size).to eq(20)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end
    # Test suite for GET /projects/:id
    describe 'GET /projects/:id' do
        before { get "/projects/#{project_id}", params: {}, headers: headers }

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
        let(:valid_attributes) do 
            { title: 'Learn Ruby', created_by: user.id.to_s }.to_json
        end

        context 'when the request is valid' do
            before { post '/projects' , params: valid_attributes, headers: headers }

            it 'creates a project' do
                expect(json['title']).to eq('Learn Ruby')
                expect(json['created_by']).to eq(user.id.to_s)
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            let(:valid_attributes) { { title: nil }.to_json }
            before { post '/projects', params: valid_attributes, headers: headers }

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
        let(:valid_attributes) { { title: 'Chores' }.to_json }

        context 'when the record exists' do
            before { put "/projects/#{project_id}", params: valid_attributes, headers: headers }
      
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
        before { delete "/projects/#{project_id}", params: {}, headers: headers }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end
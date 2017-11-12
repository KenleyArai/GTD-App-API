require 'rails_helper'

RSpec.describe 'Projects API', type: :request do

    # Initialize test data
    let!(:actions) { create_list(:action, 20) }
    let(:action_id) { actions.first.id }

    # Test suite for GET /projects
    describe 'GET /projects' do
    end
    # Test suite for GET /projects/:id
    describe 'GET /projects/:id' do
    end
    # Test suite for POST /projects
    describe 'POST /projects' do
    end
    # Test suite for PUT /projects/:id
    describe 'PUT /projects/:id' do
    end
    # Test suite for DELETE /projects/:id
    describe 'DELETE /projects/:id' do
    end
end
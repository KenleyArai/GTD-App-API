require 'rails_helper'

RSpec.describe 'Projects API', type: :request do

    # Initialize test data
    let(:user) { create(:user) }
    let!(:areas) { create_list(:area, 5, created_by: user.id) }
    let(:area_id) { areas.first.id }
    # authorize request
    let(:headers) { valid_headers }

    # Test Suite for GET /areas
    # Test Suite for POST /areas

    # Test Suite for GET /areas/:id
    # Test Suite for PUT /areas/:id
    # Test Suite for DELETE /areas/:id

end
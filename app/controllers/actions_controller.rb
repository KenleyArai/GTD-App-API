class ActionsController < ApplicationController
    before_action :set_project
    before_action :set_project_action, only: [:show, :update, :destroy]

    # GET /projects/:project_id/actions
    def index
        json_response(@project.actions)
    end

    # GET /projects/:projects_id/actions/:id
    def show
        json_response(@action)
    end

    # POST /projects/:project_id/actions
    def create
        @project.actions.create!(action_params)
        json_response(@project, :created)
    end

    # PUT /projects/:project_id/actions/:id
    def update
        @action.update(action_params)
        head :no_content
    end

    # DELETE
    def destroy
        @action.destroy
        head :no_content
    end

    private

    def action_params
        params.permit(:title, :done)
    end

    def set_project
        @project = Project.find(params[:project_id])
    end

    def set_project_action
        @action = @project.actions.find_by!(id: params[:id]) if @project
    end
end

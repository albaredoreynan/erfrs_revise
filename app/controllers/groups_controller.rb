class GroupsController < InheritedResources::Base
	actions :all, except: :show
  
  respond_to :html, :json

  protected

    def permitted_params
      params.permit(group: %i[code status])
    end

    def collection
      @groups = apply_scopes(Group)
      @groups = @groups.paginate(page: params[:page]) unless request.url =~ /json$/
      @groups
    end
end
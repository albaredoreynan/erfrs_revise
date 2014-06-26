class GroupsController < InheritedResources::Base
	actions :all, except: :show
  before_filter :subheader
  respond_to :html, :json

  def subheader
    @hide_nav = true
  end
  
  protected

    def permitted_params
      params.permit(group: %i[code status fund_source_id])
    end

    def collection
      @groups = apply_scopes(Group)
      @groups = @groups.paginate(page: params[:page]) unless request.url =~ /json$/
      @groups
    end
end
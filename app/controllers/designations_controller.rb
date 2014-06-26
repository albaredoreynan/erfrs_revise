class DesignationsController < InheritedResources::Base
	actions :all, except: :show
  before_filter :subheader, except: :show
  respond_to :html, :json

  def subheader
    @hide_nav = true
  end
  protected

    def permitted_params
      params.permit(designation: %i[name])
    end

    def collection
      @designations = apply_scopes(Designation)
      @designations = @designations.paginate(page: params[:page]) unless request.url =~ /json$/
      @designations
    end
end
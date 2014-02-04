class BarangaysController < InheritedResources::Base
  actions :all, except: :show

  respond_to :html, :json

  has_scope :municipality_id

  protected

    def permitted_params
      params.permit(barangay: %i[municipality_id name])
    end

    def collection
      @barangays = apply_scopes(Barangay)
      @barangays = @barangays.paginate(page: params[:page]) unless request.url =~ /json$/
      @barangays
    end

end

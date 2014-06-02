class NewsInformationsController < InheritedResources::Base
	actions :all
  
  respond_to :html, :json

  # def show
  # 	@news_information = NewsInformation.find params[:id]
  # end

  protected

    def permitted_params
      params.permit(news_information: %i[title content publish_start publish_end])
    end

    def collection
      @news_informations = apply_scopes(NewsInformation)
      @news_informations = @news_informations.paginate(page: params[:page]) unless request.url =~ /json$/
      @news_informations
    end
end
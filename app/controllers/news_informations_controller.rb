class NewsInformationsController < InheritedResources::Base
	actions :all
  before_filter :subheader, except: :show
  respond_to :html, :json

  def index
    # see news_information model for pagination display
    @news_informations = NewsInformation.order(created_at: :desc).paginate(:page => params[:page])
  end

  def show
   	@news_information = NewsInformation.find params[:id]
    @news_list = NewsInformation.where("publish_start <= ? and publish_end >= ?", Date.today, Date.today ).recent
  end

  def subheader
    @hide_nav = true
  end
  
  protected

    def permitted_params
      params.permit(news_information: %i[title content publish_start publish_end news_image])
    end

    def collection
      @news_informations = apply_scopes(NewsInformation)
      @news_informations = @news_informations.paginate(page: params[:page]) unless request.url =~ /json$/
      @news_informations
    end
end

RestpieApp.controllers :applications do
  
  get :index, :map => "/" do
    @applications = Restpie::API.applications
    @application = @applications.values.first
    redirect url_for(:applications, :show, :application_id => @application[:name])
  end
  
  get :show, :with => :application_id,  do
    @applications = Restpie::API.applications
    @application = @applications[params[:application_id]]
    render 'api'
  end
  
end
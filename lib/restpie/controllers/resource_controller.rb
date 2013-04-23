RestpieApp.controllers :resources, :parent => :applications do
  
  get :show, :with => :resource_id do
    @applications = Restpie::API.applications
    @application = @applications[params[:application_id]]
    @resource = @application[:resources][params[:resource_id]]
    render :resource
  end
  
end
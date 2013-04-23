RestpieExample.controllers :example do
  
  _description "Full description for api"
  _param "parameter1", :description => "Test Parameter"
  _param "parameter2", :description => "Test Parameter 2 description", :required => true
  get :api, :provides => [:json], :description => 'Test Short Description' do
    Restpie::API.resources.inspect
  end
  
  _description "Full description for api1"
  get :api1, :provides => [:xml], :description => 'Test Short Description2' do
    Restpie::API.resources.inspect
  end
end
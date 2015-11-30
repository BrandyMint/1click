class App::AppFunnelsController < App::ApplicationController
  inherit_resources

  protected

  def collection
    get_collection_ivar || set_collection_ivar(end_of_association_chain.page(params[:page]).order('created_at desc'))
  end

  def begin_of_association_chain
    current_app
  end

  def permitted_params
    params.permit(app_funnel: [ :title, app_funnel_event_definitions_attributes: [:id, :event_definition_id, :_destroy] ])
  end
end

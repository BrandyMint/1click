class App::EventDefinitionsController < ApplicationController
  def index
  end

  def create
    current_app.event_definitions.create! event_definition_params

    redirect_to event_definitions_path
  rescue ActiveRecord::RecordInvalid => err
    render :new, locals: { event_definition: err.record }
  end

  def show
    render locals: { event_definition: app_event_definitions.find(params[:id]) }
  end

  def new
    render locals: { event_definition: EventDefinition.new }
  end

  private

  def event_definition_params
    params[:event_definition].permit!
  end
end

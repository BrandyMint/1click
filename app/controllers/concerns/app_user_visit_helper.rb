module AppUserVisitHelper
  extend ActiveSupport::Concern

  included do
    helper_method :app_user_visit
  end

  private

  def app_user_visit
    return unless params[:visitId]

    AppUserVisit.where(visitId: params[:visitId]).first!
  end
end

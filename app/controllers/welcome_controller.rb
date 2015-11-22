class WelcomeController < ApplicationController
  def index
  end

  def form
    flash[:success] = 'Форму приняли'
    redirect_to :back
  end

  def reset
    AppUser.delete_all
    AppUserSession.delete_all
    AppUserVisit.delete_all
    AppEvent.delete_all
    AppPageEvent.delete_all

    flash[:success] = 'Все удалил'
    redirect_to :back
  end
end

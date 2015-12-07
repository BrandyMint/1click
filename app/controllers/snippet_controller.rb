class SnippetController < ApplicationController
  include SnippetHelper
  skip_before_action :verify_authenticity_token

  def create
    snippet_on!

    redirect_to :back
  end

  def destroy
    snippet_off!

    redirect_to :back
  end
end

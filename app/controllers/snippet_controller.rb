class SnippetController < ApplicationController
  include SnippetHelper

  def create
    snippet_on!

    redirect_to :back
  end

  def destroy
    snippet_off!

    redirect_to :back
  end
end

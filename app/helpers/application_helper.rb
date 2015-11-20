module ApplicationHelper
  def insert_snippet
    render 'snippet', app_id: 1, src: "https://rawgit.com/BrandyMint/aristotel/master/dist/art.js"
  end
end

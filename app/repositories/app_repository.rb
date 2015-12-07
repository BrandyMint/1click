class AppRepository < ROM::Repository::Base
  relations :apps

  def find(id)
    apps.find(id).as(:app).one!
  end

  #def find!(id)
    #apps.find(id).one!
  #end

  def all_apps
    apps.all.as(:app)
  end
end

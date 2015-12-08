module AppCommands
  class Create < ROM::Commands::Create[:sql]
    relation :apps
    register_as :create
    result :one
  end
end

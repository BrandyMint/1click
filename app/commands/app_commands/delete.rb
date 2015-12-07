module AppCommands
  class Delete < ROM::Commands::Delete[:sql]
    relation :apps
    register_as :delete
    result :one
  end
end

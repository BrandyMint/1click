module AppIdentifiedUserCommands
  class Delete < ROM::Commands::Delete[:sql]
    relation :app_identified_users
    register_as :delete
    result :one
  end
end

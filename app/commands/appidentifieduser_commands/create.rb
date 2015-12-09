module AppIdentifiedUserCommands
  class Create < ROM::Commands::Create[:sql]
    relation :app_identified_users
    register_as :create
    result :one
  end
end

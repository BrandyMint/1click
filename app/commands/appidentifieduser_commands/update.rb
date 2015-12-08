module AppIdentifiedUserCommands
  class Update < ROM::Commands::Update[:sql]
    relation :app_identified_users
    register_as :update
    result :one

    # define a validator to use
    # validator AppIdentifiedUserValidator
  end
end

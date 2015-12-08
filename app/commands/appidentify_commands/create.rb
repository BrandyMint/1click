module AppIdentifyCommands
  class Create < ROM::Commands::Create[:sql]
    relation :app_identifies
    register_as :create
    result :one

    # define a validator to use
    # validator AppIdentifyValidator
  end
end

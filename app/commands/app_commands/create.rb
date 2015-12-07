module AppCommands
  class Create < ROM::Commands::Create[:sql]
    relation :apps
    register_as :create
    result :one

    # define a validator to use
    # validator AppValidator
  end
end

module AppCommands
  class Update < ROM::Commands::Update[:sql]
    relation :apps
    register_as :update
    result :one

    # define a validator to use
    # validator AppValidator
  end
end

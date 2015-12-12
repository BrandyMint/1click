module DBTables
  private

  %i(app_identified_users app_identifies app_user_identifies).each do |k|
    define_method k do
      db[k]
    end
  end

  def db
    ROM.env.gateways[:default].connection
  end
end

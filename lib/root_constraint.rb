class RootConstraint
  def self.matches?(request)
    request.subdomain.blank?
  end
end

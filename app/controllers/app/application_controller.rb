class App::ApplicationController < ::ApplicationController
  include CurrentUser
  include AppAuthority
end

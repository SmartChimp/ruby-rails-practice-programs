class ApplicationController < ActionController::Base
  protect_from_forgery

  Jbuilder.key_format camelize: :lower
end

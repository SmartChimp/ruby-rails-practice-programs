class ApplicationController < ActionController::Base
  include SessionHelper
  protect_from_forgery

  Jbuilder.key_format camelize: :lower


end

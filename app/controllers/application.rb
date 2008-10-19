# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem

  layout :no_layout_for_xhr

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '92ba1dbf88075e8c786b0f6743b9fe33'

  filter_parameter_logging :password

protected

  def no_layout_for_xhr
    request.xhr? ? false : 'application'
  end

end

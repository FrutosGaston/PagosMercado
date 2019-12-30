require_relative './concerns/responses.rb'
require_relative './concerns/exception_handler.rb'

class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
end

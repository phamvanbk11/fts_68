class Admin::BaseController < ApplicationController
  before_action :require_logged_in_user, :require_logged_in_as_admin
  load_and_authorize_resource
end

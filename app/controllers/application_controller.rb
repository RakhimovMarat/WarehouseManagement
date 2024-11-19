# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit

  rescue_from Pundit::NotAuthorizedError do |_exeption|
    flash[:error] = 'У вас нет прав на доступ к этой странице'
    redirect_back(fallback_location: root_path)
  end
end

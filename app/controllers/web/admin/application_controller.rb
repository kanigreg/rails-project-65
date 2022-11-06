# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  layout 'dashboard'

  before_action :authenticate_admin

  private

  def authenticate_admin
    return redirect_to root_path, alert: t('admin_only') unless current_user&.admin?
  end
end

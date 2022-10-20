# frozen_string_literal: true

class Web::Admin::DashboardController < Web::Admin::ApplicationController
  def index
    authorize :dashboard, :index?

    @bulletins = Bulletin.under_moderation
  end
end

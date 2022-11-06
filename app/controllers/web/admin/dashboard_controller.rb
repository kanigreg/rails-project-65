# frozen_string_literal: true

class Web::Admin::DashboardController < Web::Admin::ApplicationController
  def index
    @bulletins = Bulletin.under_moderation
  end
end

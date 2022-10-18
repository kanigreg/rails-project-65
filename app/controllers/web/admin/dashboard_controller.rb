# frozen_string_literal: true

class Web::Admin::DashboardController < Web::Admin::ApplicationController
  def index
    authorize :dashboard, :index?

    @bulletins = policy_scope(Bulletin, policy_scope_class: DashboardPolicy::Scope)
  end
end

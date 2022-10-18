# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    authorize Bulletin

    @bulletins = policy_scope(Bulletin)
  end
end

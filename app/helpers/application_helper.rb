# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def human_event(state)
    Bulletin.aasm.human_event_name(state)
  end
end

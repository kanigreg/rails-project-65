# frozen_string_literal: true

module ApplicationHelper
  include AuthConcern

  def human_event(state)
    Bulletin.aasm.human_event_name(state)
  end

  def options_for_bulletin_states
    Bulletin.aasm.states.map { |state| [state.human_name, state.name] }
  end
end

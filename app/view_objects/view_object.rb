class ViewObject
  attr_reader :context

  include Rails.application.routes.url_helpers
  include ActionView::Helpers
  include ActionView::Context

  # comment these two lines out if not using cancan
  include CanCan::ControllerAdditions
  delegate :current_ability, to: :context

  def initialize context
    @context = context
  end
end

class Activity < PublicActivity::Activity
  delegate :name, to: :owner, prefix: true
  delegate :name, to: :trackable, prefix: true
  delegate :title, to: :trackable, prefix: true

  scope :load_by_current_user, ->user do
    where(owner: user).includes :trackable, :owner
  end
  scope :recent, ->{order created_at: :desc}
  scope :pagination, ->page_params do
    page(page_params).per Settings.activity.per_page
  end
end

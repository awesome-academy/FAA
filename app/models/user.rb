class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  acts_as_follower
  has_friendship
  devise :database_authenticatable, :registerable, :lockable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  before_save :super_admin_reject

  has_many :articles
  has_many :education_posts, class_name: Education::Post.name
  has_many :education_socials, class_name: Education::Social.name
  has_many :education_comments, class_name: Education::Comment.name
  has_many :education_rates, class_name: Education::Rate.name
  has_many :education_project_members, class_name: Education::ProjectMember.name
  has_many :course_members, class_name: Education::CourseMember.name
  has_many :education_courses, through: :course_members, source: :course
  has_many :education_projects, through: :education_project_members,
    source: :project
  has_many :education_user_groups, class_name: Education::UserGroup.name
  has_many :education_groups, class_name: Education::Group.name,
    through: :education_user_groups, source: :group
  has_one :education_program_member, class_name: Education::ProgramMember.name
  has_one :education_learning_program, through: :education_program_member
  has_many :education_images, class_name: Education::Image.name,
    as: :imageable, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  has_one :avatar, class_name: Image.name, foreign_key: :id,
    primary_key: :avatar_id
  has_one :cover_image, class_name: Image.name, foreign_key: :id,
    primary_key: :cover_image_id
  has_one :info_user
  has_many :user_certificates, dependent: :destroy
  has_many :certificates, through: :user_certificates

  accepts_nested_attributes_for :info_user
  accepts_nested_attributes_for :certificates, allow_destroy: true

  delegate :introduce, to: :info_user, prefix: true, allow_nil: true
  delegate :birthday, to: :info_user, prefix: true, allow_nil: true
  delegate :school, to: :info_user, prefix: true, allow_nil: true

  enum role: [:user, :admin, :trainer, :super_admin]
  enum education_status: [:blocked, :active], _prefix: true

  validates :name, presence: true,
    length: {maximum: Settings.user.max_length_name}
  validates :email, presence: true
  validates :education_status, presence: true

  scope :not_in_object, ->object do
    where("id NOT IN (?)", object.users.pluck(:user_id)) if object.users.any?
  end

  scope :in_object, ->object do
    where("id IN (?)", object.users.pluck(:user_id))
  end

  scope :newest, ->{order created_at: :desc}

  scope :by_active, ->{where education_status: :active}

  ROLES = %w(user trainer admin super_admin)

  def role? base_role
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def certificates_attributes= attributes
    self.certificates.delete_all
    attributes.to_a.each do |attribute|
      if attribute[1][:id].present? && attribute[1][:_destroy] != 1
        self.certificates |= [Certificate.find_by(id: attribute[1][:id])]
      end
    end
    super
  end

  class << self
    def import file
      (2..spreadsheet(file).last_row).each do |row|
        value = Hash[[header_of_file(file),
          spreadsheet(file).row(row)].transpose]
        user = find_by(id: value["id"]) || new
        user.attributes = value.to_hash.slice *value.to_hash.keys
        unless user.save
          raise "#{I18n.t('education.import_user.row_error')} #{row}: \
            #{user.errors.full_messages}"
        end
      end
    end

    def open_spreadsheet file
      case File.extname file.original_filename
      when ".csv" then Roo::CSV.new file.path
      when ".xls" then Roo::Excel.new file.path
      when ".xlsx" then Roo::Excelx.new file.path
      else raise "#{I18n.t('education.import_user.unknow_format')}: \
        #{file.original_filename}"
      end
    end

    def spreadsheet file
      open_spreadsheet file
    end

    def header_of_file file
      spreadsheet(file).row 1
    end

    def from_omniauth auth
      User.find_or_initialize_by(email: auth.info.email).tap do |user|
        user.assign_attributes name: auth.info.name, uid: auth.uid,
          provider: auth.provider, email: auth.info.email
        user.password = Devise
          .friendly_token[Settings.friendly_token_low,
            Settings.friendly_token_high]
        user.save
      end
    end
  end

  def is_user? user
    user == self
  end

  def send_email_request_friend user
    FriendRequestMailer.friend_request(self, user).deliver_later
  end

  private

  def super_admin_reject
    user = User.find_by id: self.id
    throw :abort if self.role == Settings.user_role.super_admin &&
      user.role != self.role
  end
end

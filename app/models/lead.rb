class Lead < ApplicationRecord
  belongs_to :assignee, optional: true, class_name: "User"
  has_one :lead_stage, dependent: :destroy
  has_one :stage, through: :lead_stage
  has_many :lead_contacts, dependent: :destroy
  has_many :contacts, through: :lead_contacts

  validates :name, presence: true

  before_validation :ensure_lead_stage

  def stage_id=(value)
    ensure_lead_stage
    lead_stage.stage_id = value
  end

  private

  def ensure_lead_stage
    build_lead_stage(stage: Stage.lead.first) if lead_stage.blank?
  end
end

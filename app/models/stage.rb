class Stage < ApplicationRecord
  has_many :lead_stages

  enum kind: {
    lead: 0
  }

  before_destroy :reassign_lead_stages
  validates :name, presence: true, uniqueness: { scope: :kind }

  private

  def reassign_lead_stages
    lead_stages.update_all(
      stage_id: Stage.lead.where.not(id: id).first.id
    )
  end
end

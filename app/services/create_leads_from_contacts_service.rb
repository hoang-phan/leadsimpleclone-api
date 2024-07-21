class CreateLeadsFromContactsService
  attr_reader :contact_ids, :stage_id, :assignee_id

  def initialize(contact_ids:, stage_id:, assignee_id:)
    @contact_ids = contact_ids
    @stage_id = stage_id
    @assignee_id = assignee_id
  end

  def call
    contact_ids.map do |contact_id|
      Lead.create!(contact_ids: [contact_id], stage_id:, assignee_id:)
    end
  end
end

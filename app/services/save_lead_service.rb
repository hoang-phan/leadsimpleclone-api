class SaveLeadService
  attr_reader :id, :attributes

  def initialize(attributes)
    @attributes = attributes
    @id = attributes.delete(:id).presence
  end

  def call
    prepare_attributes
    lead.tap { |record| record.update(attributes) }
  end

  private

  def lead
    @lead ||= id.present? ? Lead.find(id) : Lead.new
  end

  def prepare_attributes
    attributes[:assignee_id] = attributes.delete(:assignee).to_h[:id]
    attributes[:stage_id] = attributes.delete(:stage).to_h[:id]
    attributes[:contact_ids] = attributes.delete(:contacts).map do |contact|
      contact.to_h[:id]
    end
  end
end

class SaveLeadService
  attr_reader :id, :attributes

  def initialize(attributes)
    @attributes = attributes
    @id = attributes.delete(:id).presence
  end

  def call
    lead.tap { |record| record.update(attributes) }
  end

  private

  def lead
    @lead ||= id.present? ? Lead.find(id) : Lead.new
  end
end

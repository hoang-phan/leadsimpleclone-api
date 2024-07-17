class SaveContactService
  attr_reader :id, :attributes

  def initialize(attributes)
    @attributes = attributes
    @id = attributes.delete(:id).presence
  end

  def call
    prepare_attributes
    contact.tap { |record| record.update(attributes) }
  end

  private

  def contact
    @contact ||= id.present? ? Contact.find(id) : Contact.new
  end

  def prepare_attributes
    attributes[:emails_attributes] = attributes.delete(:emails).map(&:to_h)
    attributes[:phones_attributes] = attributes.delete(:phones).map(&:to_h)
  end
end

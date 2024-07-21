class MergeContactsService
  attr_reader :contact_ids, :primary_contact_id

  def initialize(contact_ids:, primary_contact_id:)
    @contact_ids = contact_ids
    @primary_contact_id = primary_contact_id
  end

  def call
    return if primary_contact.blank? || removed_contacts.blank?

    move_leads
    move_emails
    move_phones

    removed_contacts.map(&:destroy)
  end

  private

  def move_leads
    LeadContact.where(contact: removed_contacts).update_all(contact_id: primary_contact_id)
  end

  def move_emails
    existing_emails = Set.new(primary_contact.emails.pluck(:value))
    Email.where(contact: removed_contacts).find_each do |email|
      next if existing_emails.include?(email.value)
      existing_emails << email.value
      email.update contact_id: primary_contact_id
    end
  end

  def move_phones
    existing_phones = Set.new(primary_contact.phones.pluck(:value))
    Phone.where(contact: removed_contacts).find_each do |phone|
      next if existing_phones.include?(phone.value)
      existing_phones << phone.value
      phone.update contact_id: primary_contact_id
    end
  end

  def contacts
    Contact.where(id: contact_ids)
  end

  def removed_contacts
    @removed_contacts ||= contacts.where.not(id: primary_contact_id).to_a
  end

  def primary_contact
    @primary_contact ||= contacts.find_by(id: primary_contact_id)
  end
end

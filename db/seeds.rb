if User.count < 5
  FactoryBot.create(:user, email: ENV["ADMIN_EMAIL"], password: ENV["ADMIN_PASSWORD"])
  FactoryBot.create_list(:user, 5)
end

if Source.count < 3
  FactoryBot.create(:source, name: "LeadSimple")
  FactoryBot.create_list(:source, 3)
end

if Contact.count < 5
  contacts = FactoryBot.create_list(:contact, 5, source: Source.first)

  contacts.each do |contact|
    FactoryBot.create(:email, contact: contact)
    FactoryBot.create(:phone, contact: contact)
  end
end


# build + save will not raise ActiveRecord::RecordInvalid like create
# so if the validation fail they will just continue with other data instead of breaking the script

if User.count < 5
  FactoryBot.build(:user, email: ENV["ADMIN_EMAIL"], password: ENV["ADMIN_PASSWORD"]).save
  FactoryBot.build_list(:user, 5).map(&:save)
end

if Source.count < 3
  FactoryBot.build(:source, name: "LeadSimple").save
  FactoryBot.build_list(:source, 3).map(&:save)
end

if Contact.count < 5
  contacts = FactoryBot.create_list(:contact, 5, source: Source.first)

  contacts.each do |contact|
    FactoryBot.build(:email, contact: contact).save
    FactoryBot.build(:phone, contact: contact).save
  end
end


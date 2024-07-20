# build + save will not raise ActiveRecord::RecordInvalid like create
# so if the validation fail they will just continue with other data instead of breaking the script

# Create users
if User.count < 5
  FactoryBot.build(:user, email: ENV["ADMIN_EMAIL"], password: ENV["ADMIN_PASSWORD"]).save
  FactoryBot.build_list(:user, 5).map(&:save)
else
  User.find_by(email: ENV["ADMIN_EMAIL"]).update(password: ENV["ADMIN_PASSWORD"], password_confirmation: ENV["ADMIN_PASSWORD"])
end

# Create sources
if Source.count < 3
  FactoryBot.build(:source, name: Source::LEAD_SIMPLE_SOURCE).save
  FactoryBot.build_list(:source, 3).map(&:save)
end

# Create stages
Stage.find_or_create_by kind: :lead, name: "New Lead", color: "#E6852F"
Stage.find_or_create_by kind: :lead, name: "Working", color: "#C78B31"
Stage.find_or_create_by kind: :lead, name: "Closing", color: "#A89132"
Stage.find_or_create_by kind: :lead, name: "New Client", color: "#3BAC6B"
Stage.find_or_create_by kind: :lead, name: "Lost - Pricing", color: "#D55B5B"
Stage.find_or_create_by kind: :lead, name: "Lost - Lack of Service Offering", color: "#D55B5B"
Stage.find_or_create_by kind: :lead, name: "Lost - Unresponsive Lead", color: "#D55B5B"
Stage.find_or_create_by kind: :lead, name: "Lost - Hired Competitor", color: "#D55B5B"
Stage.find_or_create_by kind: :lead, name: "Lost - Self Managing", color: "#D55B5B"
Stage.find_or_create_by kind: :lead, name: "Lost - Kept Existing PM", color: "#D55B5B"
Stage.find_or_create_by kind: :lead, name: "Lost - Sold Property", color: "#D55B5B"
Stage.find_or_create_by kind: :lead, name: "Lost - Other", color: "#D55B5B"
Stage.find_or_create_by kind: :lead, name: "Lost - Poor Fit (No Follow Up)", color: "#D55B5B"
Stage.find_or_create_by kind: :lead, name: "Invalid", color: "#6F6F6F"
Stage.find_or_create_by kind: :lead, name: "Duplicate", color: "#6F6F6F"
Stage.find_or_create_by kind: :lead, name: "Education Nurture - 10 Mistakes", color: "#5B8ED2"
Stage.find_or_create_by kind: :lead, name: "PM Hiring Guide", color: "#5B8ED2"
Stage.find_or_create_by kind: :lead, name: "Education Nurture - Investor Guide", color: "#5B8ED2"
Stage.find_or_create_by kind: :lead, name: "Unable to Contact", color: "#5B8ED2"
Stage.find_or_create_by kind: :lead, name: "Active Nurturing (1-3 months)", color: "#5B8ED2"
Stage.find_or_create_by kind: :lead, name: "Passive Nurturing (4+ months)", color: "#5B8ED2"


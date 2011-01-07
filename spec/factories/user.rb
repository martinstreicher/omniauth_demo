Factory.sequence :user_name do |uid|
  "user#{uid}"
end

Factory.sequence :values do |v|
  (1..5).map {|i| Factory :topic }.map(&:name).join(', ')
end

Factory.define :user do |u|
  u.confirmed_at          { Time.now }
  u.email                 { Faker::Internet.email }
  u.first_name            { Faker::Name.first_name }
  u.last_name             { Faker::Name.last_name }
  u.password              { 'password' }
  u.password_confirmation { |p| p.password }
  u.user_name             { Factory.next :user_name }
end

Factory.define :user_with_intent_values, :parent => :user do |u|
  u.connection_values     { Factory.next :values }
  u.interest_values       { Factory.next :values }
  u.skill_values          { Factory.next :values }
end

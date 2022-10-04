# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John Doe' }
    sequence(:email) { |n| "jdoe+#{n}@example.com" }
    password { SecureRandom.hex(8) }
  end
end

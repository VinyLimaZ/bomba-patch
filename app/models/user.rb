# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :password, presence: true, on: :create

  has_secure_password :password
end

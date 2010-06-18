class Person < ActiveRecord::Base
  has_many :email_addresses
  has_one :account
  has_many :open_id_identities
  has_and_belongs_to_many :roles
end
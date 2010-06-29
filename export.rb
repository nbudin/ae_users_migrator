require 'rubygems'
gem 'activerecord', '3.0.0.beta4'
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => "mysql",
  :host => "localhost",
  :username => "root",
  :database => "ae_users"
)

class Account < ActiveRecord::Base
  belongs_to :person
end

class EmailAddress < ActiveRecord::Base
  belongs_to :person
end

class OpenIdIdentity < ActiveRecord::Base
  belongs_to :person
end

class Person < ActiveRecord::Base
  has_many :email_addresses
  has_one :account
  has_many :open_id_identities
  has_and_belongs_to_many :roles
end

class Role < ActiveRecord::Base
  has_and_belongs_to_many :people
end

associations = [:email_addresses, :account, :open_id_identities, :roles]
people = Person.includes(associations).all
json = people.as_json(:include => associations).to_json
puts json

#!/usr/bin/env ruby

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

  def as_json(options = {})
    json = super(options)

    %w{email_addresses account open_id_identities roles}.each do |assn|
      json[assn] = self.send(assn).as_json
    end

    json
  end
end

class Role < ActiveRecord::Base
  has_and_belongs_to_many :people
end

puts Person.includes(:email_addresses, :account, :open_id_identities, :roles).all.to_json

require 'active_record'

module AeUsersMigrator
  module Export
    class Account < ActiveRecord::Base
      belongs_to :person, :class_name => "AeUsersMigrator::Export::Person"
    end

    class EmailAddress < ActiveRecord::Base
      belongs_to :person, :class_name => "AeUsersMigrator::Export::Person"
    end

    class OpenIdIdentity < ActiveRecord::Base
      belongs_to :person, :class_name => "AeUsersMigrator::Export::Person"
    end

    class Person < ActiveRecord::Base
      has_many :email_addresses, :class_name => "AeUsersMigrator::Export::EmailAddress"
      has_one :account, :class_name => "AeUsersMigrator::Export::Account"
      has_many :open_id_identities, :class_name => "AeUsersMigrator::Export::OpenIdIdentity"
      has_and_belongs_to_many :roles, :class_name => "AeUsersMigrator::Export::Role"

      def as_json(options = {})
        json = super(options)
        if json['person']
          json = json['person']
        end

        %w{email_addresses account open_id_identities roles}.each do |assn|
          json[assn] = self.send(assn).as_json
        end

        json
      end
    end

    class Role < ActiveRecord::Base
      has_and_belongs_to_many :people, :class_name => "AeUsersMigrator::Export::Person"
    end
  end
end
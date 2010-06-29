require 'json'

module AeUsersMigrator
  module Import
    class EmailAddress
      attr_accessor :address, :created_at, :updated_at, :primary, :id
      
      def initialize(json)
        %w{address created_at updated_at primary id}.each do |f|
          self.send("#{f}=", json[f])
        end
      end
    end
    
    class OpenIdIdentity
      attr_accessor :id, :identity_url
      
      def initialize(json)
        %w{id identity_url}.each do |f|
          self.send("#{f}=", json[f])
        end
      end
    end
    
    class Account
      attr_accessor :activation_key, :created_at, :updated_at, :id, :password, :active
      
      def initialize(json)
        %w{activation_key created_at updated_at id password active}.each do |f|
          self.send("#{f}=", json[f])
        end
      end
    end
    
    class Role
      attr_accessor :name
      
      def initialize(json)
        self.name = json["name"]
      end
    end
    
    class Person
      attr_reader :email_addresses, :open_id_identities, :account, :roles
      attr_accessor :nickname, :birthdate, :gender, :id, :firstname, :lastname, :phone, :best_call_time
      
      def initialize(json)
        @email_addresses = json["email_addresses"].collect do |ea_record|
          EmailAddress.new(ea_record["email_address"])
        end
        
        @open_id_identities = json["open_id_identities"].collect do |oid_record|
          OpenIdIdentity.new(oid_record["open_id_identity"])
        end
        
        @roles = json["roles"].collect do |role_record|
          Role.new(role_record["role"])
        end
        
        if json["account"]
          @account = Account.new(json["account"]["account"])
        end
        
        %w{nickname birthdate gender id firstname lastname phone best_call_time}.each do |f|
          self.send("#{f}=", json[f])
        end
      end
      
      def primary_email_address
        @email_addresses.select { |ea| ea.primary }.first || @email_addresses.first
      end
    end
    
    class Dumpfile
      attr_reader :people
      
      def initialize
        @people = {}
      end
      
      def self.load(file)
        json = JSON.load(file)
        df = Dumpfile.new
        
        json.each do |item|
          if item["person"]
            p = Person.new(item["person"])
            df.people[p.id] = p
          end
        end
        
        return df
      end
    end
  end
end

class DumpfilesController < ApplicationController
  before_filter :validate_login!, :except => :index
  
  def index
  end
  
  def generate
    associations = [:email_addresses, :account, :open_id_identities, :roles]
    people = Person.includes(associations).all
    json = people.to_json(:include => associations)
    
    send_data Zlib::Deflate.deflate(json), :filename => "ae_users_dumpfile.json.gz"
  end
  
  protected
  def validate_login!
    ea = EmailAddress.find_by_address(params[:login][:email])
    p = ea.try(:person)
    unless p.try(:account).try(:password) == Digest::MD5.hexdigest(params[:login][:password])
      flash[:alert] = "Invalid email address or password"
      redirect_to root_url
    end
  end
end

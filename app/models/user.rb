# encoding: UTF-8

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation

  has_many :documents

  before_create { generate_token(:auth_token) }

  validates :email, :presence => { :is => true, :message => "L'email est obligatoire."}
  validates :email, :uniqueness => { :is => true, :message => "Cet email existe déjà." }
  validates :password, :presence => { :is => true, :message => "Le password est obligatoire."}
  validates :password, :confirmation => { :is => true, :message => "Le password et sa confirmation ne correspondent pas." }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64      
    end while User.exists?(column => self[column])
  end

  def disk_usage
    res = 0
    documents.each do |document|
      document.sheets.each do |sheet|
        res += sheet.paper.file.size
      end
    end
    return ActionController::Base.helpers.number_to_human_size(res)
  end

end

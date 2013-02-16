#encoding: UTF-8

class Document < ActiveRecord::Base
  attr_accessible :title, :description
  belongs_to :user

  has_many :sheets, :order => "paper ASC"

  validates :title, :presence => { :is => true, :message => "Le titre est obligatoire." }

  before_destroy :check_sheet_existance

  private
  def check_sheet_existance
    if sheets.count > 0
      errors.add :base, "Suppression interdite. Le document contient des fichiers."
    end
    errors.blank? #return false, to not destroy the element, otherwise, it will delete.
  end

end

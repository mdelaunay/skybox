#encoding: UTF-8

class Sheet < ActiveRecord::Base
  attr_accessible :paper, :document
  belongs_to :document, :touch => true
  mount_uploader :paper, PaperUploader

  default_scope order('paper ASC')

  validates :paper, :presence => { :is => true, :message => "Vous devez sélectionner un fichier."}

  validate :check_filename_uniqueness

  def filename
    paper_name = paper.to_s[(paper.to_s.rindex("/") + 1)..paper.to_s.length]
  end
  def original_filename
    paper_name = filename[(filename.index("_") + 1)..filename.length]
  end

  private
  def check_filename_uniqueness
    document.sheets.each do |sheet|
      if sheet.original_filename == filename
        errors.add :base, "Un fichier de même nom existe déjà dans ce document."
        break
      end
    end
  end

end

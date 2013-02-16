#encoding: UTF-8

class SheetsController < ApplicationController

  def create 
    @document = current_user.documents.find(params[:document_id])
    @sheet = @document.sheets.create(params[:sheet])
  end

  def destroy
    @document = current_user.documents.find(params[:document_id])
    @sheet = @document.sheets.find(params[:id])
    if @sheet.destroy
      flash[:success] = "Fichier supprimé avec succès."
      redirect_to edit_document_path(@document)
    else
      flash[:error] = "Erreur de suppression du fichier."
      parse_error_messages(@sheet)
      redirect_to edit_document_path(@document)
    end
  end


end

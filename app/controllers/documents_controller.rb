#encoding: UTF-8

class DocumentsController < ApplicationController
  def index
    @documents = current_user.documents.all
  end

  def new
    @document = Document.new()
  end

  def edit
    @document = current_user.documents.find(params[:id])
    @back_link = document_path(@document)
  end

  def create 
    @document = current_user.documents.new(params[:document])
    if @document.save
      flash[:success] = "document créé avec succès."
      redirect_to edit_document_path(@document)
    else
      flash.now[:error] = "Erreur de création du document."
      parse_error_messages(@document)
      render :new
    end
  end

  def update
    @document = current_user.documents.find(params[:id])
    if @document.update_attributes(params[:document])
      flash[:success] = "Document modifié avec succès."
      redirect_to document_path(@document)
    else
      flash.now[:error] = "Erreur de modification du document."
      parse_error_messages(@document)
      @back_link = document_path(@document)
      render :edit
    end
  end

  def destroy
    @document = current_user.documents.find(params[:id])
    if @document.destroy
      flash[:success] = "Document supprimé avec succès."
      redirect_to root_path
    else
      flash[:error] = "Erreur de suppression du document."
      parse_error_messages(@document)
      redirect_to edit_document_path(@document)
    end
  end

  def show
    @document = current_user.documents.find(params[:id])
    @back_link = root_path
  end

  def clear_files
    @document = current_user.documents.find(params[:id])
    @document.sheets.each do |sheet|
      sheet.destroy
    end
    flash[:success] = "Tous les fichiers du document ont été effacés."
    redirect_to edit_document_path(@document)
  end

  def search
    @query = params[:search][:query]
    query = @query.downcase.gsub(" ", "%")
    @documents = (current_user.documents.where('LOWER(title) LIKE ?', "%#{query}%") + current_user.documents.where('LOWER(description) LIKE ?', "%#{query}%")).uniq
    @sheets = []
    current_user.documents.each do |document|
      document.sheets.where('LOWER(paper) LIKE ?', "%#{query}%").each do |sheet|
        @sheets << sheet
      end
    end
    @back_link = root_path
  end

end

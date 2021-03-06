class Admin::DocumentsController < AdminController
  load_and_authorize_resource

  def index
    @documents = Document.all
  end

  def new
    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      if @document.save
        format.html { redirect_to(admin_documents_path, :flash => { :success => "File uploaded." }) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to(admin_documents_path, :flash => { :error => "File deleted." }) }
    end
  end

  def human_name
    "files"
  end
end

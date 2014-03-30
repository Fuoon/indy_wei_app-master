class ImageAttachmentController < ApplicationController
	before_action :set_image_attachment, only: [:show, :edit, :update, :destroy]

	def index
		@image_attachments = ImageAttachment.all 
	end

	def show
	end

	def new 
		@image_attachment = ImageAttachment.new
	end

	def edit
	end

	def create
	    @image_attachment = ImageAttachment.new(image_attachment_params)

	    respond_to do |format|
	      if @image_attachment.save
	        format.html { redirect_to @image_attachment }
	        format.json { render action: 'show', status: :created, location: @image_attachment }
	      else
	        format.html { render action: 'new' }
	        format.json { render json: @image_attachment.errors, status: :unprocessable_entity }
	      end
	    end
	  end

  # PATCH/PUT /post_attachments/1
  # PATCH/PUT /post_attachments/1.json
  def update
    respond_to do |format|
      if @image_attachment.update(image_attachment_params)
        format.html { redirect_to @image_attachment }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @image_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_attachments/1
  # DELETE /post_attachments/1.json
  def destroy 
    @image_attachment.destroy
    if @image_attachment.article != nil
      redirect_to edit_article_path(@image_attachment.article)
    else
      redirect_to edit_game_path(@image_attachment.game)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image_attachment
      @image_attachment = ImageAttachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_attachment_params
      params.require(:image_attachment).permit(:article_or_game_id, :image)
    end
end

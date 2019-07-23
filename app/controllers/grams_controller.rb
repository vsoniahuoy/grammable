class GramsController < ApplicationController
  def new
    @gram = Gram.new
  end

  def index
  end

  def create
    # save in the database
    @gram = Gram.create(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def gram_params
    # pull the data
    params.require(:gram).permit(:message)
  end
end

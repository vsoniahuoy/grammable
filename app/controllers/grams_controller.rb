class GramsController < ApplicationController
  def new
    @gram = Gram.new
  end

  def index
  end

  def create
    # save in the database
    @gram = Gram.create(gram_params)
    redirect_to root_path
  end

  private

  def gram_params
    # pull the data
    params.require(:gram).permit(:message)
  end
end

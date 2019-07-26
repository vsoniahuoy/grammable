class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @grams = Gram.all
  end


  def new
    @gram = Gram.new
  end


  def create
    # save in the database
    @gram = current_user.grams.create(gram_params)

    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
  end


  def edit
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    return render_not_found(:forbidden) if @gram.user != current_user
  end

  def update
    @gram = Gram.find_by_id(params[:id])
    # if @gram is nil, render error 404 page
    return render_not_found if @gram.blank?
    # controller needs to prevent users from updating grams that they didn't create
    return render_not_found(:forbidden) if @gram.user != current_user


    @gram.update_attributes(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end



  def destroy
    @gram = Gram.find_by_id(params[:id])
    return render_not_found if @gram.blank?
    # prevent unauthorize user from deleting grams
    return render_not_found(:forbidden) if @gram.user != current_user
    @gram.destroy
    redirect_to root_path
  end 


  
  private

  def gram_params
    # pull the data
    params.require(:gram).permit(:message, :picture)
  end


  # Make it generic that render_not found can apply to not found and forbidden cases
  def render_not_found(status=:not_found)
    render plain: "#{status.to_s.titleize} :(", status: status
  end

  # def render_not_found
  # if @gram.blank only apply to blank.
  #   if @gram.blank?
  #     render plain: 'Not Found :(', status: :not_found
  #   end
  # end
end

class RequestsController < ApplicationController
  REQUESTS_PER_PAGE = 7
  def index
    @requests2 = Request.search(params[:search_term])
    @requests = @requests2.order(created_at: :desc).
                       page(params[:page]).
                       per(REQUESTS_PER_PAGE)
  end

  def new
    @request = Request.new
  end

  def create
    request_params = params.require(:request).permit(:name, :email, :department, :message)
    @request = Request.new request_params
      if @request.save
        redirect_to requests_path
      else
        render :new
      end
  end

  def show
    @request = Request.find params[:id]
    @requests2 = Request.search(params[:search_term])
    @requests = @requests2.order(created_at: :desc).
                       page(params[:page]).
                       per(REQUESTS_PER_PAGE)
  end

  def destroy
    @request = Request.find params[:id]
    @request.destroy
    redirect_to requests_path
  end

  def edit
    @requests2 = Request.find params[:id]
  end

  def update
    @requests2 = Request.find params[:id]
    request_params = params.require(:request).permit([:name, :email, :department, :message])
      if @requests2.update request_params
        redirect_to request_path(@requests2)
      else
        p @requests2.errors.full_messages.join(", ")

        render :edit
      end
  end

  def search
    if params[:search_term]
      query = "%#{params[:search_term]}%"
      @requests = Request.where(
      "name ILIKE :search_term OR department ILIKE :search_term",
       {search_term: query}
      )
    else
      @requests = Request.all
    end
     render :index
  end
end

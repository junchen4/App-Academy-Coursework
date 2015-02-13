class BandsController < ApplicationController

  def index
    @bands = Band.all
    render :index
  end

  def new
    render :new
  end

  def create
    @band = Band.new(band_params)
    @band.save!
    redirect_to band_url(@band)
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def show
    @band = Band.find(params[:id]) #does Band.find(band_params[:id]) also work?
    render :show
  end

  def update
    @band = Band.find(params[:id])
    @band.update(band_params)
    # @band.name = band_params[:name]
    # @band.save!
    redirect_to band_url(@band)
  end


  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name) #only works if user has input a form with band[smth_here]
  end

end

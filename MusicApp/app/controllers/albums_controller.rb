class AlbumsController < ApplicationController

  def new
    @band = Band.find(params[:band_id])
    render :new
  end

  def create

    fail
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    @album.update(album_params)
    # @album[:name] = params[:album][:name]
    # @album[:live_or_studio] = params[:album][:live_or_studio]
    redirect_to album_url(@album)
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band)
  end

  private
  def album_params
    params.require(:band).permit(:name, :live_or_studio)
  end

end

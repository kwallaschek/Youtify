class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :current_song, :changeSong


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_song
    @current_song
  end

  def changeSong
    #@current_song = Yt::Video.new id: Song.find(params[:song]).yid
    @current_song = Song.find(params[:song])
    respond_to do |format|
      #format.html{render'layouts/changeSong'}
      format.js{render 'layouts/changeSong', layout: false}
    end
  end

  def nextSong
    if params[:next] == "next"
      nextSong = Song.where('playlist_id = ? AND id > ?', params[:playlist_id], params[:id])
      @current_song = nextSong.first
    elsif params[:next] == "prev"
      nextSong = Song.where('playlist_id = ? AND id < ?', params[:playlist_id], params[:id])
      @current_song = nextSong.last
    end


    respond_to do |format|
      #format.html{render'layouts/changeSong'}
      format.js{render 'layouts/changeSong', layout: false}
    end
  end
  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:alert] = t('alert require user')
      redirect_to login_path
    end
  end


  def default_url_options
    { locale: I18n.locale }
  end

  def change_locale
    puts params[:loc]
    case params[:loc]
    when 'de'
      I18n.locale = :de
    when 'us'
      I18n.locale = :en
    when 'jp'
      I18n.locale = :jp
    end
    redirect_back fallback_location: root_path
  end

  around_action :switch_locale

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

end

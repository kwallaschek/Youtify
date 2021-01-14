class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
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

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SetLayoutDefaults

  before_action :set_i18n_locale_from_params
 
  def default_url_options
    { locale: I18n.locale }
  end

  protected

    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def set_i18n_locale_from_params
      if params[:set_locale]
        I18n.locale = params[:set_locale]
        return
      end

      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = 
            "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end
end
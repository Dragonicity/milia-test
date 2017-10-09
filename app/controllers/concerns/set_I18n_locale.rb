module SetI18nLocale

  extend ActiveSupport::Concern

  included do
    before_action :set_i18n_locale
  end

  def set_i18n_locale

    # Set the locale to the default :en if params[:locale] is not set

    I18n.locale = params[:locale] || I18n.default_locale

    # params[:set_locale] is set if a form locale selector is used

    if params[:set_locale]
      I18n.locale = params[:set_locale]
      default_url_options
      return
    end

    # Check locale is in the locale whitelist in case manually entered

    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        I18n.locale = params[:locale]
        default_url_options
      else
        flash.now[:notice] = 
            "#{params[:locale]} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end

  def default_url_options
    { locale: I18n.locale }
  end

end
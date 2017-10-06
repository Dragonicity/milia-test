I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
I18n.available_locales = [:en, :fr, :'zh-CN', :'zh-TW']
I18n.default_locale = :en
I18n.config.enforce_available_locales = false

LANGUAGES = [
  ['English', 'en'],
  ['Français'.html_safe, 'fr'],
  ['大陆简体'.html_safe, 'zh-CN'],
  ['台灣正體'.html_safe, 'zh-TW'],
]
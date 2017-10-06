module SetLayoutDefaults
  extend ActiveSupport::Concern

  included do
    before_action :set_defaults
  end

  def set_defaults
    @page_title   = "Milia Test"
    @seo_keywords = "Rails Milia Multi-tenancy"
    @copyright    = "&copy;".html_safe
  end
end
module ProductsHelper

  def product_img img, type
    if img.model.main_image? || img.model.thumb_nail?
      img
    elsif type == 'thumb'
      image_generator(height: '350', width: '200')
    else
      image_generator(height: '600', width: '400')
    end
  end

  def image_generator(height:, width:)
    "http://placehold.it/#{height}x#{width}"
  end

end
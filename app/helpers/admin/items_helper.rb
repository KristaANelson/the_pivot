module Admin::ItemsHelper
  def create_image(param_path)
    Image.create(title:       param_path[:img_title],
                 description: param_path[:img_description],
                 img:         param_path[:image].tempfile)
  end

  def add_image(param_path)
    @image = create_image(param_path)
    @item.update_attributes(image: @image)
    @item.save
  end

  def add_categories(category_ids)
    @categories = category_ids.map do |category_id|
      Category.find_by(id: category_id)
    end

    @categories.compact.each do |category|
      @item.categories << category
    end
  end
end

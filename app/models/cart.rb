class Cart
  attr_accessor :cart_items

  def initialize(cart_items_hash = Hash.new)
    @cart_items = cart_items_hash || Hash.new
  end

  def empty?
    @cart_items.count == 0
  end

  def add_item(item_id)
    cart_items[item_id] ||= 0
    cart_items[item_id] += 1
  end

  def count
    cart_items.values.inject(0, :+)
  end

  def remove_item(item_id)
    cart_items.except!(item_id)
  end

  def total_dollar_amount
    total = cart_items.each.reduce(0) do |total, (key, count)|
      item = Item.find(key)
      total + item.unit_price * count
    end
    "$#{(total / 100)}.00"
  end
end

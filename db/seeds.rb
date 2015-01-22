class Seed
  attr_accessor :categories, :items, :users
  def initialize
    generate_categories
    generate_items
    generate_users
    add_items_to_categories
    generate_orders
    change_order_statuses
  end

  def generate_categories
    @categories = Category.create([
                                    { name: "Main meals"},
                                    { name: "Pizzas" },
                                    { name: "Drinks" },
                                    { name: "Salads"},
                                    { name: "Desserts" },
                                    { name: "Vegetarian" }
                                  ])
  end

  def generate_items
    @items = Item.create([
      { id: 5000, title: "pizza",    description: "some cheese stuff", unit_price: "5000" },
      { title: "pizza2",   description: "some cheese stuff", unit_price: "6000" },
      { title: "pizza3",   description: "some cheese stuff", unit_price: "7000" },
      { title: "pizza4",   description: "some cheese stuff", unit_price: "54000" },
      { title: "pizza5",   description: "some cheese stuff", unit_price: "50300" },
      { title: "pizza6",   description: "some cheese stuff", unit_price: "50" },
      { title: "pizza7",   description: "some cheese stuff", unit_price: "50030" },
      { title: "pizza8",   description: "some cheese stuff", unit_price: "500" },
      { title: "pizza9",   description: "some cheese stuff", unit_price: "5000" },
      { title: "pizza10",  description: "some cheese stuff", unit_price: "4000" },
      { title: "pizza11",  description: "some cheese stuff", unit_price: "1000" },
      { title: "pizza12",  description: "some cheese stuff", unit_price: "500" },
      { title: "pizza13",  description: "some cheese stuff", unit_price: "800" },
      { title: "pizza14",  description: "some cheese stuff", unit_price: "500" },
      { title: "Veggie Pizza",  description: "Mushrooms, onions, peppers, and olives on a pizza", unit_price: "300" },
      { title: "veggies",  description: "an assortment of grilled veggies", unit_price: "500" },
      { title: "drink1",   description: "Coke",              unit_price: "200" },
      { title: "drink2",   description: "water",             unit_price: "800" },
      { title: "drink3",   description: "milk",              unit_price: "500" },
      { title: "drink4",   description: "orange juice",      unit_price: "300" },
      { title: "dessert1", description: "some cheese sweet stuff", unit_price: "200" },
      { title: "Caesar salad", description: "Just a regular Caesar salad", unit_price: "800" }
    ])
  end



  def generate_users
    @users = User.create([
                           { id: 1, full_name: "Rachel Warbelow", email: "demo+rachel@jumpstartlab.com", password: "password" },
                           { id: 2, full_name: "Jeff Casimir", email: "demo+jeff@jumpstartlab.com", password: "password", display_name: "j3" },
                           { id: 3, full_name: "Jorge Tellez", email: "demo+jorge@jumpstartlab.com", password: "password", display_name: "novohispano" },
                           { id: 4, full_name: "Josh Cheek", email: "demo+josh@jumpstartlab.com", password: "password", display_name: "josh", role: 1 }
                         ])
  end

  def generate_orders
    10.times do |i|
      user = User.find(rand(2) + 1)
      order = Order.create!(user_id: user.id, status: "ordered")
      add_items(order)
      puts "#{i} Order #{order.id}: Order for #{user.full_name} created!"
    end
    5.times do |i|
      order = Order.create!(id: 1000 + i, user_id: 3, status: "ordered")
      add_specific_items(order)
    end
  end



  private

  def add_items_to_categories
    categories[0].items = items[0..14]
    categories[1].items = items[0..14]
    categories[2].items = items[16..19]
    categories[3].items << items[20]
    categories[4].items << items[19]
    categories[5].items = [ items[14], items[15] ]
  end


  def add_items(order)
    5.times do |i|
      item = Item.find(rand(21) + 1)
      OrderItem.create(item_id: item.id, quantity: 1, order_id: order.id, line_item_price: item.unit_price)
    end
  end

  def add_specific_items(order)
    5.times do |i|
      item = Item.find(5000)
      OrderItem.create(item_id: item.id, quantity: 1, order_id: order.id, line_item_price: item.unit_price)
      puts "#{i}: Added item #{item.title} to order #{order.id}."
    end
  end

  def change_order_statuses
    3.times do |i|
      order = Order.find(i+1)
      order.status = "cancelled"
      order = Order.find(i+5)
      order.status = "completed"
    end
  end
end

Seed.new

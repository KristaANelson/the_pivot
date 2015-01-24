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
      { name: "Specialty Pizzas" },
      { name: "Submarine Sandwiches" },
      { name: "Drinks" },
      { name: "Burgers" },
      { name: "Chicken Wings" },
      { name: "Vegetarian" }
    ])
  end

  def generate_items
    @items = Item.create([
      { title:        "Pittsburgh Pizza",
        description:  "Cole slaw, fried steak,
        mozzarella cheese, shoe string buffalo fries and Riviera Dressing.",
        unit_price:   2050 },
      { title:        "Combo Pizza",
        description:  "Your choice of half and half with White, Broccoli or
      Regular Pizza,",
        unit_price:   1350 },
      { title:        "White Pizza",
        description:  "Olive oil, tomato slices, onions, mozarella,
      parmesan and spices",
        unit_price:   1350 },
      { title:        "Broccoli Cheddar",
        description:  "Broccoli topped with cheddar, monterey jack and
      mozarella cheeses",
        unit_price:   1350 },
      { title:        "Taco Pizza",
        description:  "Taco seasoned ground beef and cheddar cheese baked and
      topped with lettuce and tomato.",
        unit_price:   1850 },
      { title:        "Hawaiian Pizza",
        description:  "Cheese, ham, pineapple and maraschino cherries",
        unit_price:   1850 },
      { title:        "Steak Pizza",
        description:  "Sauteed onions with your choice of mushrooms, sweet or
      hot peppers combined with steak and topped with cheddar cheese",
        unit_price:   1850 },
      { title:        "Stuffed Pizza",
        description:  "Cheese plus your choice of any three ingredients in a
      'pizza pie'",
        unit_price:   2200 },
      { title:        "All-The-Way",
        description:  "A loaded pizza topped with cheese, pepperoni, mushrooms,
      onions, sausage, and your choice of hot or sweet peppers.",
        unit_price:   1850 },
      { title: "Veggie Pizza",
        description: "Sauce and mozzarella cheese topped with mushrooms,
      broccoli, black olives, tomatoes and onions.",
        unit_price:   1850 },
      { title:        "Western Chicken Pizza",
        description:  "Fried sweet peppers and onions with seasoned grilled
      chicken and BBQ sauce topped with cheddar and monterey jack cheeses,",
        unit_price:   1850 },
      { title:        "Meat Lovers Pizza",
        description:  "Loaded with all your favorite meats - pepperoni,
      sausage, ham and bacon",
        unit_price:   1850 },
      { title:        "Chicken Finger Pizza",
        description:  "Blue cheese topped with chicken fingers with your choice
      of Buffalo or BBQ sauce and mozzarella and cheddar cheeses",
      unit_price:     1850 },
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
      { full_name: "Rachel Warbelow", email: "demo+rachel@jumpstartlab.com", password: "password" },
      { full_name: "Jeff Casimir", email: "demo+jeff@jumpstartlab.com", password: "password", display_name: "j3" },
      { full_name: "Jorge Tellez", email: "demo+jorge@jumpstartlab.com", password: "password", display_name: "novohispano" },
      { full_name: "Josh Cheek", email: "demo+josh@jumpstartlab.com", password: "password", display_name: "josh", role: 1 }
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
      order = Order.create!(user_id: 3, status: "ordered")
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
      item = Item.first
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

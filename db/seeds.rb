class Seed
  attr_accessor :categories, :items, :users, :admins
  def initialize
    generate_categories
    generate_images
    generate_items
    generate_users
    generate_admins
    add_items_to_categories
    generate_orders
    change_order_statuses
  end

  def generate_categories
    @categories = Category.create([
      { name: "Specialty Pizzas" },
      { name: "Sub Sandwiches" },
      { name: "Drinks" },
      { name: "Burgers" },
      { name: "Chicken Wings" },
      { name: "Vegetarian" }
    ])
  end

  def generate_images
    @images = Image.create([
      { title: "Heart",
        description: "Pizza Heart Excl! Gif",
        img: File.new("#{Rails.root}/spec/support/images/heart_pizza.gif") },
      { title: "Mushroom Pizza",
        description: "Mushroom Pizza Pic",
        img: File.new("#{Rails.root}/spec/support/images/mushroom.jpeg") },
      { title: "Pizza Cat",
        description: "Pizza Cat Pic",
        img: File.new("#{Rails.root}/spec/support/images/pizza_cat.jpg") },
      { title: "Pizza Shirt",
        description: "Pizza Sweatshirt Pic",
        img: File.new("#{Rails.root}/spec/support/images/pizza_large.jpg") },
      { title: "Missing",
        description: "Default Pic",
        img: File.new("#{Rails.root}/spec/support/images/missing.jpg") }
    ])
  end

  def generate_items
    @items = Item.create([
      { title:        "Pittsburgh Pizza",
        description:  "Cole slaw, fried steak,
        mozzarella cheese, shoe string buffalo fries and Riviera Dressing.",
        unit_price:   2050,
        active:       true,
        image_id: 1 },
      { title:        "Combo Pizza",
        description:  "Your choice of half and half with White, Broccoli or
      Regular Pizza,",
        unit_price:   1350,
        active:       true,
        image_id: 2 },
      { title:        "White Pizza",
        description:  "Olive oil, tomato slices, onions, mozarella,
      parmesan and spices",
        unit_price:   1350,
        active:       true,
        image_id: 3 },
      { title:        "Broccoli Cheddar",
        description:  "Broccoli topped with cheddar, monterey jack and
      mozarella cheeses",
        unit_price:   1350,
        active:       true,
        image_id: 4 },
      { title:        "Taco Pizza",
        description:  "Taco seasoned ground beef and cheddar cheese baked and
      topped with lettuce and tomato.",
        unit_price:   1850,
        active:       true,
        image_id: 1 },
      { title:        "Hawaiian Pizza",
        description:  "Cheese, ham, pineapple and maraschino cherries",
        unit_price:   1850,
        active:       true,
        image_id: 2 },
      { title:        "Steak Pizza",
        description:  "Sauteed onions with your choice of mushrooms, sweet or
      hot peppers combined with steak and topped with cheddar cheese",
        unit_price:   1850,
        active:       true,
        image_id: 3 },
      { title:        "Stuffed Pizza",
        description:  "Cheese plus your choice of any three ingredients in a
      'pizza pie'",
        unit_price:   2200,
        active:       true,
        image_id: 4 },
      { title:        "All-The-Way",
        description:  "A loaded pizza topped with cheese, pepperoni, mushrooms,
      onions, sausage, and your choice of hot or sweet peppers.",
        unit_price:   1850,
        active:       true,
        image_id: 1 },
      { title:        "Veggie Pizza",
        description:  "Sauce and mozzarella cheese topped with mushrooms,
      broccoli, black olives, tomatoes and onions.",
        unit_price:   1850,
        active:       true,
        image_id: 2 },
      { title:        "Western Chicken Pizza",
        description:  "Fried sweet peppers and onions with seasoned grilled
      chicken and BBQ sauce topped with cheddar and monterey jack cheeses,",
        unit_price:   1850,
        active:       true,
        image_id: 3 },
      { title:        "Meat Lovers Pizza",
        description:  "Loaded with all your favorite meats - pepperoni,
      sausage, ham and bacon",
        unit_price:   1850,
        active:       true,
        image_id: 4 },
      { title:        "Chicken Finger Pizza",
        description:  "Blue cheese topped with chicken fingers with your choice
      of Buffalo or BBQ sauce and mozzarella and cheddar cheeses",
        unit_price:   1850,
        active:       true,
        image_id: 1 },
      { title:        "Chicken Supreme",
        description:  "Grilled chicken strips with peppers, onions and
      mushrooms",
        unit_price:   875,
        active:       true,
        image_id: 2 },
      { title:        "Burger Royale",
        description:  "Hamburger and Italian sausage with lettuce and tomato or
      fried peppers and onions",
        unit_price:   875,
        active:       true,
        image_id: 3 },
      { title:        "Steak Supreme",
        description:  "Sirloin steak with sweet or hot peppers, mushroom and
      fried onions with lots of melted cheese and a touch of hot sauce",
        unit_price:   875,
        active:       true,
        image_id: 4 },
      { title:        "Sausage Supreme",
        description:  "Italian sausage with sweet or hot peppers, mushroom
      and fried onions with lots of melted cheese and a touch of hot sauce",
        unit_price:   875,
        active:       true,
        image_id: 1 },
      { title:        "Chicken Deluxe",
        description:  "Chicken and ham with blue cheese, lettuce and
      tomato",
        unit_price:   875,
        active:       true,
        image_id: 1 },
      { title:        "Bacon Cheeseburger",
        description:  "It's a bacon cheeseburger. It has hamburger, cheese
        and bacon",
        unit_price:   875,
        active:       true,
        image_id: 2 },
      { title:        "Steak and Sausage Royale",
        description:  "Italian Sausage and Steak with lettuce and tomatoes
      or Supreme Style with fried onions and peppers.",
        unit_price:   875,
        active:       true,
        image_id: 3 },
      { title:        "Ultimate Mix",
        description:  "Italian Sausage, ham, salami, and capicola with
      lettuce and tomatoes or fried peppers and onions",
        unit_price:   875,
        active:       true,
        image_id: 4 },
      { title:        "Baked Beef",
        description:  "Fried onions, melted cheddar cheese, lettuce and
      tomatoes",
        unit_price:   875,
        active:       true,
        image_id: 1 },
      { title:        "Steak-n-Rings",
        description:  "Our steak sub topped with our golden fried onion rings,
      melted cheese, and lettuce and tomato",
        unit_price:   875,
        active:       true,
        image_id: 2 },
      { title:        "Steak and Chicken",
        description:  "Our sirloin steak topped with chicken fingers,
      lettuce, tomato and BBQ sauce",
        unit_price:   875,
        active:       true,
        image_id: 3 },
      { title:        "Steak or Sausage and Spinach",
        description:  "Served on homemade garlic bread with fried onions",
        unit_price:   875,
        active:       true,
        image_id: 1 },
      { title:      "Pittsburgh Sub",
        description:  "Half a pound of steak topped with jack cheddar cheese,
      cole slaw, shoestring Buffalo fries, tomatoes, Riviera dressing, and
      onions on request.",
        unit_price:   950,
        active:       true,
        image_id: 4 },
      { title:        "Can of Soda",
        description:  "12 oz can of soda",
        unit_price:   100,
        active:       true,
        image_id: 4 },
      { title:        "Bottled Water",
        description:  "20 ounce bottle of water",
        unit_price:   150,
        active:       true,
        image_id: 2 },
      { title:        "2 Liter Soda",
        description:  "2 Liter bottle of Soda",
        unit_price:   250,
        active:       true,
        image_id: 1 },
      { title:        "Bacon Blue Burger",
        description:  "A quarter pound Black Angus beef served on a round roll
      with pickle, lettuce, tomato on request with bacon and blue cheese",
        unit_price:   525,
        active:       true,
        image_id: 3 },
      { title:        "Hamburger",
        description:  "A quarter pound Black Angus beef served on a round roll
      with pickle, lettuce, tomato on request",
        unit_price:   300,
        active:       true,
        image_id: 1 },
      { title:        "Cheeseburger",
        description:  "A quarter pound Black Angus beef served on a round roll
      with cheese - Pickle, lettuce, tomato on request",
        unit_price:   350,
        active:       true,
        image_id: 1 },
      { title:        "Double Cheeseburger",
        description:  "A whole half pound of Black Angus beeef servedf on
      a round roll - Pickle, lettuce, tomato on request",
        unit_price:   600,
        active:       true,
        image_id: 4 },
      { title:        "Pizza Burger",
        description:  "A quarter pound Black Angus beef topped with pizza
      sauce and mozzarealla cheese",
        unit_price:   475,
        active:       true,
        image_id: 2 },
      { title:        "Mushroom Burger",
        description:  "A quarter pound of Black Angus beef topped with
      sauteed mushrooms, onions and provolone cheese.",
        unit_price:   475,
        active:       true,
        image_id: 3 },
      { title:        "Roast Beef Sandwich",
        description:  "Homemade roast beef on a choice of Kaiser or Weck
      roll",
        unit_price:   575,
        active:       true,
        image_id: 3 },
      { title:        "Mini Wings",
        description:  "Order of 5 wings",
        unit_price:   475,
        active:       true,
        image_id: 2 },
      { title:        "Single Wings",
        description:  "Order of 10 wings",
        unit_price:   795,
        active:       true,
        image_id: 1 },
      { title:        "Double Wings",
        description:  "Order of 20 wings",
        unit_price:   1350,
        active:       true,
        image_id: 1 },
      { title:        "Triple Wings",
        description:  "Order of 30 wings",
        unit_price:   1895,
        active:       true,
        image_id: 4 },
      { title:        "Bucket of Wings",
        description:  "Order of 50 wings",
        unit_price:   2695,
        active:       true,
        image_id: 1 },
    ])
  end

  def generate_users
    @users = User.create([
      { full_name:             "Rachel Warbelow",
        email:                 "demo+rachel@jumpstartlab.com",
        password:              "password",
        password_confirmation: "password" },
      { full_name:             "Jeff Casimir",
        email:                 "demo+jeff@jumpstartlab.com",
        password:              "password",
        password_confirmation: "password",
        display_name:          "j3" },
      { full_name:             "Jorge Tellez",
        email:                 "demo+jorge@jumpstartlab.com",
        password:              "password",
        password_confirmation: "password",
        display_name:          "novohispano" }
    ])
  end

  def generate_admins
    Admin.create(full_name:             "Admin",
                 email:                 "admin@admin.com",
                 password_confirmation: "password",
                 password:              "password")
    Admin.create(full_name:             "Josh Cheek",
                 email:                 "demo+josh@jumpstartlab.com",
                 password_confirmation: "password",
                 display_name:          "josh")
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
    Order.all.each do |order|
      order.update_attributes(total_price: order.order_total)
    end
  end

  private

  def add_items_to_categories
    categories[0].items = items[0..12]
    categories[1].items = items[13..25]
    categories[2].items = items[26..28]
    categories[3].items = items[29..35]
    categories[4].items = items[36..40]
    categories[5].items = [items[1], items[2], items[3], items[9]]
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

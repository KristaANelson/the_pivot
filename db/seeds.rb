class Seed
  attr_accessor :categories, :items, :users, :admins
  def initialize
    generate_categories
    generate_images
    generate_items
    generate_users
    generate_admins
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
        img: File.new("#{Rails.root}/spec/support/images/missing.jpg") },
      { title: "Pittsburgh Pizza",
        description: "Pittsburgh Pizza",
        img: File.new("#{Rails.root}/spec/support/images/pit_pizza.jpg") },
      { title: "Combo Pizza",
        description: "Combo Pizza",
        img: File.new("#{Rails.root}/spec/support/images/combo_pizza.jpg") },
      { title: "White Pizza",
        description: "White Pizza",
        img: File.new("#{Rails.root}/spec/support/images/white_pizza.jpg") },
      { title: "Broccoli Cheddar",
        description: "Broccoli Cheddar",
        img: File.new("#{Rails.root}/spec/support/images/broc_ched.jpg") },
      { title: "Taco Pizza",
        description: "Taco Pizza",
        img: File.new("#{Rails.root}/spec/support/images/taco_pizza.jpg") },
      { title: "Hawaiian Pizza",
        description: "Hawaiian Pizza",
        img: File.new("#{Rails.root}/spec/support/images/hawaiian_pizza.png") },
      { title: "Steak Pizza",
        description: "Steak Pizza",
        img: File.new("#{Rails.root}/spec/support/images/steak_pizza.jpg") },
      { title: "Stuffed Pizza",
        description: "Stuffed Pizza",
        img: File.new("#{Rails.root}/spec/support/images/stuffed.jpg") },
      { title: "All The Way Pizza",
        description: "All The Way Pizza",
        img: File.new("#{Rails.root}/spec/support/images/all_the_way.jpg") },
      { title: "Veggie Pizza",
        description: "Veggie Pizza",
        img: File.new("#{Rails.root}/spec/support/images/veggie_pizza.jpg") },
      { title: "Chicken Supreme",
        description: "Chicken Supreme",
        img: File.new("#{Rails.root}/spec/support/images/deluxe_chix.png") },
      { title: "Sausage Supreme",
        description: "Sausage Supreme",
        img: File.new("#{Rails.root}/spec/support/images/sausage.jpg") },
      { title: "Steak and Sausage Royale",
        description: "Steak and Sausage Royale",
        img: File.new("#{Rails.root}/spec/support/images/steak_saus.jpg") },
      { title: "Pittsburgh Sub",
        description: "Pittsburgh Sub",
        img: File.new("#{Rails.root}/spec/support/images/pit_sub.jpg") },
      { title: "Cans of Soda",
        description: "Cans of Soda",
        img: File.new("#{Rails.root}/spec/support/images/soda.jpg") },
      { title: "2Liter Soda",
        description: "2 liter Soda",
        img: File.new("#{Rails.root}/spec/support/images/2liter.png") },
      { title: "Bottle of Water",
        description: "Bottle of Water",
        img: File.new("#{Rails.root}/spec/support/images/waters.jpg") },
      { title: "Hamburger",
        description: "Hamburger",
        img: File.new("#{Rails.root}/spec/support/images/hamburger.jpg") },
      { title: "Cheeseburger",
        description: "Cheeseburger",
        img: File.new("#{Rails.root}/spec/support/images/cheeseburger.jpg") },
      { title: "Double Cheeseburger",
        description: "Double Cheeseburger",
        img: File.new("#{Rails.root}/spec/support/images/dbl_cheese.jpg") },
      { title: "Pizza Burger",
        description: "Pizza Burger",
        img: File.new("#{Rails.root}/spec/support/images/pizza_burg.png") },
      { title: "10 Wings",
        description: "10 Wings",
        img: File.new("#{Rails.root}/spec/support/images/10_wings.jpg") },
      { title: "20 Wings",
        description: "20 Wings",
        img: File.new("#{Rails.root}/spec/support/images/20_wings.jpg") },
      { title: "30 Wings",
        description: "30 Wings",
        img: File.new("#{Rails.root}/spec/support/images/30_wings.jpg") },
      { title: "Bucket of Wings",
        description: "Bucket of Wings",
        img: File.new("#{Rails.root}/spec/support/images/bucket_wings.jpg") },
    ])
  end

  def generate_items
    @item1 = Item.new(
      title:        "Pittsburgh Pizza",
      description:  "Cole slaw, fried steak,
      mozzarella cheese, shoe string buffalo fries and Riviera Dressing.",
      unit_price:   2050,
      active:       true,
      image_id:     6)
    @item1.categories << @categories[0]

    @item2 = Item.new(
      title:        "Combo Pizza",
      description:  "Your choice of half and half with White, Broccoli or
      Regular Pizza,",
      unit_price:   1350,
      active:       true,
      image_id:     7)
    @item2.categories = [@categories[0], @categories[5]]

    @item3 = Item.new(
      title:        "White Pizza",
      description:  "Olive oil, tomato slices, onions, mozarella,
      parmesan and spices",
      unit_price:   1350,
      active:       true,
      image_id:     8)
    @item3.categories = [@categories[0], @categories[5]]

    @item4 = Item.new(
      title:        "Broccoli Cheddar",
      description:  "Broccoli topped with cheddar, monterey jack and
      mozarella cheeses",
      unit_price:   1350,
      active:       true,
      image_id:     9)
    @item4.categories = [@categories[0], @categories[5]]

    @item5 = Item.new(
      title:        "Taco Pizza",
      description:  "Taco seasoned ground beef and cheddar cheese baked and
      topped with lettuce and tomato.",
      unit_price:   1850,
      active:       true,
      image_id:     10)
    @item5.categories = [@categories[0], @categories[5]]

    @item6 = Item.new(
      title:        "Hawaiian Pizza",
      description:  "Cheese, ham, pineapple and maraschino cherries",
      unit_price:   1850,
      active:       true,
      image_id:     11)
    @item6.categories << @categories[0]

    @item7 = Item.new(
      title:        "Steak Pizza",
      description:  "Sauteed onions with your choice of mushrooms, sweet or
      hot peppers combined with steak and topped with cheddar cheese",
      unit_price:   1850,
      active:       true,
      image_id:     12)
    @item7.categories << @categories[0]

    @item8 = Item.new(
      title:        "Stuffed Pizza",
      description:  "Cheese plus your choice of any three ingredients in a
      'pizza pie'",
      unit_price:   2200,
      active:       true,
      image_id:     13)
    @item8.categories = [@categories[0], @categories[5]]

    @item9 = Item.new(
      title:        "All-The-Way",
      description:  "A loaded pizza topped with cheese, pepperoni, mushrooms,
      onions, sausage, and your choice of hot or sweet peppers.",
      unit_price:   1850,
      active:       true,
      image_id:     14)
    @item9.categories << @categories[0]

    @item10 = Item.new(
      title:        "Veggie Pizza",
      description:  "Sauce and mozzarella cheese topped with mushrooms,
      broccoli, black olives, tomatoes and onions.",
      unit_price:   1850,
      active:       true,
      image_id:     15)
    @item10.categories = [@categories[0], @categories[5]]

    @item11 = Item.new(
      title:       "Chicken Supreme",
      description: "Grilled chicken strips with peppers, onions and
      mushrooms",
      unit_price:  875,
      active:      true,
      image_id:    16)
    @item11.categories << @categories[1]

    @item12 = Item.new(
      title:        "Sausage Supreme",
      description:  "Italian sausage with sweet or hot peppers, mushroom
      and fried onions with lots of melted cheese and a touch of hot sauce",
      unit_price:   875,
      active:       true,
      image_id:     17)
    @item12.categories << @categories[1]

    @item13 = Item.new(
      title:        "Steak and Sausage Royale",
      description:  "Italian Sausage and Steak with lettuce and tomatoes
      or Supreme Style with fried onions and peppers.",
      unit_price:   875,
      active:       true,
      image_id:     18)
    @item13.categories << @categories[1]

    @item14 = Item.new(
      title:        "Pittsburgh Sub",
      description:  "Half a pound of steak topped with jack cheddar cheese,
      cole slaw, shoestring Buffalo fries, tomatoes, Riviera dressing, and
      onions on request.",
      unit_price:   950,
      active:       true,
      image_id:     19)
    @item14.categories << @categories[1]

    @item15 = Item.new(
      title:        "Can of Soda",
      description:  "12 oz can of soda",
      unit_price:   100,
      active:       true,
      image_id:     20)
    @item15.categories << @categories[2]

    @item16 = Item.new(
    title:        "2 Liter Soda",
    description:  "2 Liter bottle of Soda",
    unit_price:   250,
    active:       true,
    image_id:     21)
    @item16.categories << @categories[2]

    @item17 = Item.new(
      title:        "Bottled Water",
      description:  "20 ounce bottle of water",
      unit_price:   150,
      active:       true,
      image_id:     22)
    @item17.categories << @categories[2]



    @item18 = Item.new(
      title:        "Hamburger",
      description:  "A quarter pound Black Angus beef served on a round roll
      with pickle, lettuce, tomato on request",
      unit_price:   300,
      active:       true,
      image_id:     23)
    @item18.categories << @categories[3]

    @item19 = Item.new(
      title:        "Cheeseburger",
      description:  "A quarter pound Black Angus beef served on a round roll
      with cheese - Pickle, lettuce, tomato on request",
      unit_price:   350,
      active:       true,
      image_id:     24)
    @item19.categories << @categories[3]

    @item20 = Item.new(
      title:        "Double Cheeseburger",
      description:  "A whole half pound of Black Angus beeef servedf on
      a round roll - Pickle, lettuce, tomato on request",
      unit_price:   600,
      active:       true,
      image_id:     25)
    @item20.categories << @categories[3]

    @item21 = Item.new(
      title:        "Pizza Burger",
      description:  "A quarter pound Black Angus beef topped with pizza
      sauce and mozzarealla cheese",
      unit_price:   475,
      active:       true,
      image_id:     26)
    @item21.categories << @categories[3]

    @item22 = Item.new(
      title:        "Single Wings",
      description:  "Order of 10 wings",
      unit_price:   795,
      active:       true,
      image_id:     27)
    @item22.categories << @categories[4]

    @item23 = Item.new(
      title:        "Double Wings",
      description:  "Order of 20 wings",
      unit_price:   1350,
      active:       true,
      image_id:     28)
    @item23.categories << @categories[4]

    @item24 = Item.new(
      title:        "Triple Wings",
      description:  "Order of 30 wings",
      unit_price:   1895,
      active:       true,
      image_id:     29)
    @item24.categories << @categories[4]

    @item25 = Item.new(
      title:        "Bucket of Wings",
      description:  "Order of 50 wings",
      unit_price:   2695,
      active:       true,
      image_id:     30)
    @item25.categories << @categories[4]

    @item1.save
    @item2.save
    @item3.save
    @item4.save
    @item5.save
    @item6.save
    @item7.save
    @item8.save
    @item9.save
    @item10.save
    @item11.save
    @item12.save
    @item13.save
    @item14.save
    @item15.save
    @item16.save
    @item17.save
    @item18.save
    @item19.save
    @item20.save
    @item21.save
    @item22.save
    @item23.save
    @item24.save
    @item25.save
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

  def add_items(order)
    5.times do |i|
      item = Item.find(rand(20) + 1)
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

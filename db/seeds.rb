class Seed
  attr_accessor :categories, :items, :users, :admins, :venues, :events
  def initialize
    generate_categories
    generate_images
    generate_venues
    generate_events
    generate_users
    generate_items
    generate_admins
    #generate_orders
    #change_order_statuses
  end

  def generate_categories
    @categories = Category.create([
      { name: "Sports" },
      { name: "Music" },
      { name: "Theater" },
    ])
  end

  def generate_images
    @images = Image.create([
      { title: "Blazers vs. Nuggets",
        description: "Lillard vs Nuggets",
        img: File.new("#{Rails.root}/spec/support/images/blazers-nuggets.jpg") },
      { title: "Hannibal Burress",
        description: "Hannibal Burress Headshot",
        img: File.new("#{Rails.root}/spec/support/images/hannibal-buress.jpg") },
      { title: "Pitbull and Enrique Iglesias",
        description: "Pitbull and Enrique Being Bosses",
        img: File.new("#{Rails.root}/spec/support/images/pitbull-enrique.jpg") }
    ])
  end

  def generate_venues
    @venues = Venue.create([
     { name: "Pepsi Center",
       location: "Denver, CO" },
     { name: "Boulder Theater",
       location: "Boulder, CO" },
    ])
  end

  def generate_events
    @event1 = Event.new(
      title:        "Portland Trailblazers at Denver Nuggets",
      description:  "Come watch the Portland Trailblazer smash the Denver Nuggets.",
      date:         10.days.from_now,
      approved:     true)
    @event1.image      = @images[0]
    @event1.venue      = @venues[0]
    @event1.categories << @categories[0]

    @event2 = Event.new(
      title:        "Hannibal Burress",
      description:  "Come watch funny man Hannibal Burress at the Boulder Theater",
      date:         12.days.from_now,
      approved:     true)
    @event2.image      = @images[1]
    @event2.venue      = @venues[1]
    @event2.categories << @categories[2]

    @event3 = Event.new(
      title:        "Pitbull and Enrique Iglesias",
      description:  "The dynamic duo take the stage.",
      date:         22.days.from_now,
      approved:     true)
    @event3.image      = @images[2]
    @event3.venue      = @venues[0]
    @event3.categories << @categories[1]

    @event1.save
    @event2.save
    @event3.save
  end

  def generate_users
    @users = User.create!([
      { full_name:             "Rachel Warbelow",
        email:                 "demo+rachel@jumpstartlab.com",
        password:              "password",
        password_confirmation: "password",
        display_name:          "rwarbelow" },
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

  def generate_items
    @item1 = Item.new(
      unit_price:      3999,
      pending:         false,
      sold:            false,
      section:         220,
      row:             18,
      seat:            "RR",
      delivery_method: "electronic")
    @item1.user  = @users[0]
    @item1.event = @event1

    @item2 = Item.new(
      unit_price:      6924,
      pending:         false,
      sold:            false,
      section:         "BALC II RGT",
      row:             "HH",
      seat:            16,
      delivery_method: "physical")
    @item2.user  = @users[1]
    @item2.event = @event2

    @item3 = Item.new(
      unit_price:      6924,
      pending:         false,
      sold:            false,
      section:         "BALC II RGT",
      row:             "HH",
      seat:            17,
      delivery_method: "physical")
    @item3.user  = @users[1]
    @item3.event = @event2

    @item4 = Item.new(
      unit_price:      6924,
      pending:         false,
      sold:            false,
      section:         "BALC II RGT",
      row:             "HH",
      seat:            18,
      delivery_method: "physical")
    @item4.user  = @users[1]
    @item4.event = @event2

    @item5 = Item.new(
      unit_price:      41705,
      pending:         false,
      sold:            false,
      section:         "Club 212",
      row:             "1",
      seat:            1,
      delivery_method: "electronic")
    @item5.user  = @users[2]
    @item5.event = @event1

    @item6 = Item.new(
      unit_price:      45649,
      pending:         false,
      sold:            false,
      section:         "Loge 128",
      row:             "8",
      seat:            29,
      delivery_method: "physical")
    @item6.user  = @users[2]
    @item6.event = @event1

    @item1.save
    @item2.save
    @item3.save
    @item4.save
    @item5.save
    @item6.save
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

  #def generate_orders
    #10.times do |i|
      #user = User.find(rand(2) + 1)
      #order = Order.create!(user_id: user.id, status: "ordered")
      #add_items(order)
      #puts "#{i} Order #{order.id}: Order for #{user.full_name} created!"
    #end
    #5.times do |i|
      #order = Order.create!(user_id: 3, status: "ordered")
      #add_specific_items(order)
    #end
    #Order.all.each do |order|
      #order.update_attributes(total_price: order.order_total)
    #end
  #end

  #private

  #def add_items(order)
    #5.times do |i|
      #item = Item.find(rand(20) + 1)
      #OrderItem.create(item_id: item.id, quantity: 1, order_id: order.id, line_item_price: item.unit_price)
    #end
  #end

  #def add_specific_items(order)
    #5.times do |i|
      #item = Item.first
      #OrderItem.create(item_id: item.id, quantity: 1, order_id: order.id, line_item_price: item.unit_price)
      #puts "#{i}: Added item #{item.title} to order #{order.id}."
    #end
  #end

  #def change_order_statuses
    #3.times do |i|
      #order = Order.find(i+1)
      #order.status = "cancelled"
      #order = Order.find(i+5)
      #order.status = "completed"
    #end
  #end
end

Seed.new

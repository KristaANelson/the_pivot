require 'rails_helper'

RSpec.describe Image, type: :model do
  it "is invalid without a title" do
    item = build(:image, title: nil)

    expect(item).not_to be_valid
  end

  it "is valid with title, desc, and img_file_name" do
    item = build(:image)

    expect(item).to be_valid
  end

  it "is invalid without a description" do
    item = build(:image, description: nil)

    expect(item).not_to be_valid
  end

  it "is invalid without a img_file_name" do
    item = build(:image, img_file_name: nil)

    expect(item).not_to be_valid
  end

  it "is invalid with a duplicate image title" do
    image1 = create(:image)
    item = build(:image, title: image1.title)

    expect(item).not_to be_valid
  end

  it "can be associated with an event" do
    image = create(:image)
    event = build(:event, image_id: image.id)
    
    expect(event.image.title).to eq(image.title)
  end
end

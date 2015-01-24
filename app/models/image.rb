class Image < ActiveRecord::Base
  has_many :items

  has_attached_file :img,
    :styles => { :menu_list => "150x150>", :item_list => "400x400>"  },
    :default_url => "/images/:style/missing.jpg"
  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :img, presence: true
end

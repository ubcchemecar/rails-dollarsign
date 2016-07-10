class Record < ActiveRecord::Base
  belongs_to :user
  delegate :name, :to => :user, :prefix => :user, :allow_nil => true
  enum status: [:pending, :reviewed, :approved, :rejected]
  enum category: {electrical: 0, battery: 1, chemical: 2, mechanical: 3, conference: 4, outreach: 5, misc: 6}

  validates :item, presence: true
  validates :description, presence: true
  validates_format_of :price, :with => /\A\d+\.*\d{0,2}\z/
  validates :quantity, numericality: { only_integer: true }
  validates :category, presence: true
  validates :supplier, presence: true
  validates :link, presence: true
  validates :status, presence: true
end
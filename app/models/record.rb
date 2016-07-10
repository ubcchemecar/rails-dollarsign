class Record < ActiveRecord::Base
  belongs_to :user
  delegate :name, :to => :user, :prefix => :user, :allow_nil => true
  enum status: [:pending, :reviewed, :approved, :rejected]
  validates :item, presence: true
  validates :description, presence: true
  validates_format_of :price, :with => /\A\d+\.*\d{0,2}\z/
  validates :quantity, numericality: { only_integer: true }
  validates :supplier, presence: true
  validates :link, presence: true
  validates :status, presence: true
end
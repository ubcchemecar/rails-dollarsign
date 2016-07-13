class Record < ActiveRecord::Base
  belongs_to :user
  delegate :name, :to => :user, :prefix => :user, :allow_nil => true
  enum status: [:pending, :reviewed, :approved, :rejected]
  enum category: {electrical: 0, battery: 1, chemical: 2, mechanical: 3, conference: 4, outreach: 5, misc: 6}

  scope :not_rejected, -> { where.not(status: rejected) }

  validates :item, presence: true
  validates :description, presence: true
  validates :part_number, presence: true
  validates_format_of :price, :with => /\A\d+\.*\d{0,2}\z/
  validates :quantity, numericality: { only_integer: true }
  validates :category, presence: true
  validates :supplier, presence: true
  validates :link, presence: true
  validates :status, presence: true

  attr_reader :total_price
  def total_price
    return quantity*price
  end

  def self.to_csv
    attributes = %w{id created_at item description user_name quantity price category supplier part_number link total_price status updated_at }

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << attributes.map{ |attr| user.send(attr) }
      end
    end
  end

end
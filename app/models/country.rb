class Country < ActiveRecord::Base
  set_primary_key :code
  attr_accessible :name, :code

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  has_many :currencies
  has_many :visits
  has_many :countries, :through => :visits

  accepts_nested_attributes_for :currencies, :allow_destroy => true

  scope :visited, where('visits.id IS NOT NULL')
  scope :not_visited, where('visits.id IS NULL')

  def self.for_user(user)
    joins("LEFT OUTER JOIN visits ON visits.country_id = countries.code AND visits.user_id = #{user.id}").select("countries.*, visits.id as visit_id")
  end

  def visited?
    if respond_to? :visit_id
      !!visit_id
    else
      false
    end
  end
end
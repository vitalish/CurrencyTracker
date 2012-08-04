class Currency < ActiveRecord::Base
  set_primary_key :code
  attr_accessible :name, :code, :country_id

  validates_presence_of :name
  validates_presence_of :code
  validates_uniqueness_of :code, :allow_blank => true

  belongs_to :country

  scope :collected, where('visits.id IS NOT NULL')
  scope :not_collected, where('visits.id IS NULL')

  def collected?
    if respond_to? :visit_id
      !!visit_id
    else
      false
    end
  end

  def self.for_user(user)
    joins(:country).joins("LEFT OUTER JOIN visits ON visits.country_id = countries.code AND visits.user_id = #{user.id}").select("currencies.*, visits.id as visit_id")
  end
end
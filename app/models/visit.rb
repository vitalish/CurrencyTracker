class Visit < ActiveRecord::Base
  belongs_to :country
  belongs_to :user

  def date
    created_at.to_i * 1000
  end
end

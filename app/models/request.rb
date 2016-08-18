class Request < ApplicationRecord
  validates(:name, presence: {messsage: "must not be empty!"})
  validates(:email, {presence: {message: "must not be empty!"}, uniqueness: true})

  def self.recent_ten
    order(created_at: :desc).limit(10)
  end

  def self.search(search_term)
  where(["name ILIKE ? OR email ILIKE ? OR message ILIKE ? OR department ILIKE?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"])
end
end

class Song < ActiveRecord::Base

  belongs_to :user
  has_many :votes

  validates :song_title, presence: true
  validates :author, presence: true
  validates :song_url, allow_blank: true, format: { with: /(https?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})/, message: "valid url's only" }

end
class Song < ActiveRecord::Base

  validates :song_title, presence: true
  validates :author, presence: true
  validates :song_url, format: { with: /(https?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})/, message: "valid url's only" }, if: :song_url

end
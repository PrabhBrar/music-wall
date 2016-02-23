class Vote < ActiveRecord::Base

  belongs_to :song
  belongs_to :user

  validates :user_id, uniqueness: { scope: [:song_id] }

end
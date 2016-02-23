class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :song_title
      t.string :author
      t.string :song_url
      t.references :user
      t.timestamps null: false
    end

    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.timestamps
    end

    create_table :votes do |t|
      t.references :song
      t.references :user
      t.timestamps
    end
  end
end

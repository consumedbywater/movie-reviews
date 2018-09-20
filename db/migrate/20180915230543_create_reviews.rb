class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :email
      t.integer :rating
      t.integer :movie_id
      t.text :comment
      t.string :movie_title

      t.timestamps
    end
  end
end

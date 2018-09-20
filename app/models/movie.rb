class Movie
    include ActiveModel::Model
    attr_accessor :title, :release_date, :genres, :image_location, :id, :rating
end
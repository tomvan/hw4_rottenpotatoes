class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end

  def find_similar_movies
    similar_movies = Movie.find_all_by_director(director)
    similar_movies.delete(self)
    return similar_movies
  end
end

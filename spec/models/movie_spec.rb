require 'spec_helper'

describe Movie do
  fixtures :movies
  describe 'searching for similar movies' do
    it 'should return a list of movies by the same director' do
    movies(:prometheus_movie).find_similar_movies.should == [movies(:alien_movie),movies(:blade_runner_movie)]
    end
  end
end

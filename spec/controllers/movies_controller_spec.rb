require 'spec_helper'

describe MoviesController do
  describe 'find similar movies' do
      before :each do
        @fake_movie = mock('movie', :director => 'Something', :title => 'Title')
        @fake_results = [mock('Movie'), mock('Movie')]
      end
      it 'should call the model method that finds movies by id' do
        Movie.should_receive(:find).with('1').and_return(@fake_movie)
        @fake_movie.stub(:find_similar_movies).and_return(@fake_results)
        get :find_similar_movies, {:id => 1}
      end
      describe 'after finding the current movie' do
        before :each do
          Movie.stub(:find).and_return(@fake_movie)
        end
        it 'should check if the director is blank' do
          @fake_movie.director.should_receive(:blank?).and_return(false)
          @fake_movie.stub(:find_similar_movies).and_return(@fake_results)
          get :find_similar_movies, {:id => 1}
        end
        describe 'after finding a non-blank director' do
          it 'should call the model method that finds similar movies' do
            @fake_movie.stub(:find).and_return(@fake_movie)
            @fake_movie.should_receive(:find_similar_movies).and_return(@fake_results)
            get :find_similar_movies, {:id => 1}
          end
          describe 'after valid search' do
            before :each do
              @fake_movie.stub(:find).and_return(@fake_movie)
              @fake_movie.stub(:find_similar_movies).and_return(@fake_results)
              get :find_similar_movies, {:id => 1}
            end
            it 'should select the Find Similar Movies template for rendering' do
              response.should render_template('find_similar_movies')
            end
            it 'should make the search results available to that template' do
              assigns(:movies).should == @fake_results
            end
            it 'should make the current movie available to that template' do
              assigns(:movie).should == @fake_movie
            end
          end
        end
        describe 'after finding a blank director' do
          before :each do
            @fake_movie.stub(:director).and_return(nil)
          end
          it 'should add a message to Flash'do
            get :find_similar_movies, {:id => 1}
            flash[:notice].should == "'#{@fake_movie.title}' has no director info"
          end
          it 'should redirect to the index' do
            get :find_similar_movies, {:id => 1}
            response.should redirect_to(:controller => 'movies', :action => 'index')
          end
        end
      end
  end
end

class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def movie_params2
    params.require(:movie).permit(:title, :rating)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @movies = Movie.order(params[:sort])
    # @movies = Movie.all
    @all_ratings = ["G", "PG", "PG-13", "R", "NC-17"]
    # if params[:sort_by] == "title" || params[:sort_by] == "release_date"
    #   @movies = Movie.order(params[:sort])
    # # elsif params[:sort_by] == "release_date"
    # #   @movies = @movies.sort_by &:release_date
    # end
     if !(params[:ratings].nil?)
       @movies = @movies.find_all{ |m| params[:ratings].has_key?(m.rating) }
     end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end
  
  def up
   
  end
  
  def upAttempt
    @movie = Movie.find_by_title(params[:movie2update][:title])
    #@movie = Movie.find params[:id]
    if @movie
      @movie.update_attributes!(movie_params)
      flash[:notice] = "#{@movie.title} was successfully updated."
      redirect_to movie_path(@movie)
    elsif params[:movie2update][:title].blank?  || params[:movie][:title].blank?
      flash[:notice] = "ERROR: One or more field empty. Fill in all fields"
      render 'up'
    else
      flash[:notice] = "ERROR: #{params[:movie2update][:title]} wasn't found in database."
      render 'up'
    end
  end
  
  def delete
   
  end
  
  def del
    @movie = Movie.find_by_title(params[:movie2delete][:title])
    #@movie = Movie.find params[:id]
    if @movie
      @movie.destroy
      flash[:notice] = "Movie '#{@movie.title}' deleted."
      redirect_to movies_path
    elsif params[:movie2delete][:title].blank?
      flash[:notice] = "ERROR: One or more field empty. Fill in all fields"
      render 'delete'
    else
      flash[:notice] = "ERROR: #{params[:movie2delete][:title]} wasn't found in database."
      render 'delete'
    end
  end
 
  def deleteopt 
  
  end
 
  def delopt
    @movie = Movie.find_by_rating(params[:movie2delete][:rating])
    #@movie = Movie.find params[:id]
    
    if @movie
      while @movie do
        @movie.destroy
        @movie = Movie.find_by_rating(params[:movie2delete][:rating])
        if !@movie
          flash[:notice] = "All #{params[:movie2delete][:rating]} movies deleted."
          redirect_to movies_path
          break
        end
      end
    elsif params[:movie2delete][:rating].blank?
      flash[:notice] = "ERROR: One or more field empty. Fill in all fields"
      render 'deleteopt'
    else
      flash[:notice] = "ERROR: There was no #{params[:movie2delete][:rating]} movies in database."
      render 'deleteopt'
    end
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

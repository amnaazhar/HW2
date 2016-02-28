class Movie < ActiveRecord::Base
 # validates :title, presence: true
    @all_ratings = ["G", "PG", "PG-13", "R", "NC-17"]
#  validates :rating, presence: true
#  validates :release_date, presence: true
    def self.all_ratings
        @all_ratings
    end

    def all_ratings
        self.class.all_ratings
    end
    
    def ratings
        all_ratings
    end

end

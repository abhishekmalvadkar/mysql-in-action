-- Retrieve the list of all movies released after the year 2000, 
-- sorted by release year.

select * from movies m
where m.release_year > 2000
order by m.release_year
;

-- Get the total number of movies for each genre.
select m.genre, count(1) as total_movie from movies m
group by m.genre
;

-- Find the movie with the highest number of votes.
-- Moview Name | Votes

select 
    m.title, 
    r.votes 
from Ratings r
join movies m on m.movie_id = r.movie_id
order by r.votes desc limit 1
;


-- Get the names of actors who acted in movies rated above 9.0.
select * from actors a
where a.actor_id in (
        select 
            mc.actor_id 
        from MovieCast mc
        where mc.movie_id in (
            select 
                r.movie_id 
            from Ratings r
            where r.rating > 9.0
        )
)
;

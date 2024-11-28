-- Movies Table
CREATE TABLE Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year YEAR NOT NULL,
    genre VARCHAR(100),
    duration_minutes INT
);

-- Actors Table
CREATE TABLE Actors (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birth_year YEAR
);

-- Directors Table
CREATE TABLE Directors (
    director_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    birth_year YEAR
);

-- Movie Cast Table
CREATE TABLE MovieCast (
    movie_id INT,
    actor_id INT,
    role VARCHAR(255),
    PRIMARY KEY (movie_id, actor_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES Actors(actor_id)
);

-- Movie Directors Table
CREATE TABLE MovieDirectors (
    movie_id INT,
    director_id INT,
    PRIMARY KEY (movie_id, director_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (director_id) REFERENCES Directors(director_id)
);

-- Ratings Table
CREATE TABLE Ratings (
    movie_id INT,
    rating DECIMAL(3, 1) CHECK (rating >= 0 AND rating <= 10),
    votes INT,
    PRIMARY KEY (movie_id),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id)
);

-- Movies
INSERT INTO Movies (title, release_year, genre, duration_minutes)
VALUES
('The Shawshank Redemption', 1994, 'Drama', 142),
('The Godfather', 1972, 'Crime', 175),
('The Dark Knight', 2008, 'Action', 152),
('Pulp Fiction', 1994, 'Crime', 154);

-- Actors
INSERT INTO Actors (name, birth_year)
VALUES
('Morgan Freeman', 1937),
('Al Pacino', 1940),
('Christian Bale', 1974),
('Samuel L. Jackson', 1948);

-- Directors
INSERT INTO Directors (name, birth_year)
VALUES
('Frank Darabont', 1959),
('Francis Ford Coppola', 1939),
('Christopher Nolan', 1970),
('Quentin Tarantino', 1963);

-- Movie Cast
INSERT INTO MovieCast (movie_id, actor_id, role)
VALUES
(1, 1, 'Ellis Boyd "Red" Redding'),
(2, 2, 'Michael Corleone'),
(3, 3, 'Bruce Wayne / Batman'),
(4, 4, 'Jules Winnfield');

-- Movie Directors
INSERT INTO MovieDirectors (movie_id, director_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4);

-- Ratings
INSERT INTO Ratings (movie_id, rating, votes)
VALUES
(1, 9.3, 2500000),
(2, 9.2, 1700000),
(3, 9.0, 2600000),
(4, 8.9, 1800000);

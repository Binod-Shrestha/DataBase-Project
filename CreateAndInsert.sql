USE section13;

drop table if EXISTS comments;
drop table if EXISTS communityDiscussions;
drop table if EXISTS promotions;
drop table if EXISTS showTimes;
drop table if EXISTS likes_movies;
drop table if EXISTS likes_restaurants;
drop table if EXISTS reviews_movies;
drop table if EXISTS reviews_restaurants;
drop table if EXISTS restaurants;
drop table if EXISTS movies;
drop table if EXISTS users;
drop table if EXISTS attractions;
drop table if EXISTS evnts;
drop table if EXISTS sites;
drop table if EXISTS details;

CREATE TABLE details(
	title VARCHAR(200) NOT NULL,
	category VARCHAR(200) NOT NULL,
	img VARCHAR(200) NOT NULL, 
	unitNum INT NOT NULL,
	street VARCHAR(200) NOT NULL,
	city VARCHAR(200) NOT NULL,
	province VARCHAR(200) NOT NULL,
	website VARCHAR(200) NOT NULL, 
	CONSTRAINT details_pk PRIMARY KEY (title)
);

INSERT INTO details
(title, category, img, unitNum, street, city, province, website)
VALUES('Dinosaur Exhibition', 'Science', 'dinasour.png', 208, 'Great Lakes', 'Brampton', 'Ontario', 'http://tohub.ca/dino-ex/');
INSERT INTO details
(title, category, img, unitNum, street, city, province, website)
VALUES('Sahara', 'Comedy', 'Sahara.png', 231, 'My Street', 'Brampton', 'Ontario', 'http://tohub.ca/cineb/');
INSERT INTO details
(title, category, img, unitNum, street, city, province, website)
VALUES('Museum of Natural History', 'Museum', 'history.png', 235, 'Dynosaur Road', 'Toronto', 'Ontario', 'http://tohub.ca/museum/');
INSERT INTO details
(title, category, img, unitNum, street, city, province, website)
VALUES('Ivar', 'Italian Cuisine', 'ivar.png', 1121, 'King St E', 'Toronto', 'Onatrio', 'http://tohub.ca/ivar/');

CREATE TABLE sites(
	id INT NOT NULL,
	title VARCHAR(200) NOT NULL,
	CONSTRAINT sites_pk PRIMARY KEY (id), 
	CONSTRAINT sites_fk FOREIGN KEY (title)
	REFERENCES details (title)
);

INSERT INTO sites
(id, title)
VALUES(1, 'Dinosaur Exhibition');
INSERT INTO sites
(id, title)
VALUES(2, 'Sahara');
INSERT INTO sites
(id, title)
VALUES(3, 'Museum of Natural History');
INSERT INTO sites
(id, title)
VALUES(4, 'Ivar');

CREATE TABLE evnts(
	e_id INT NOT NULL,
	descrpt VARCHAR(200) NOT NULL,
	startHour VARCHAR(100) NOT NULL,
	endHour VARCHAR(100) NOT NULL,
	startDate VARCHAR(100) NOT NULL,
	endDate VARCHAR(100) NOT NULL,
	admission NUMERIC(5,2) NOT NULL,
	CONSTRAINT evnts_pk PRIMARY KEY (e_id),
	CONSTRAINT evnts_fk FOREIGN KEY (e_id)
	REFERENCES sites (id)
);

INSERT INTO evnts
(e_id, descrpt, startHour, endHour, startDate, endDate, admission)
VALUES(1, 'Dinosaur exhibition is very attractive for kids. It is coming from museum of natural history in London.', '10:00', '22:00', '2013-09-01', '2018-11-01', 13);

CREATE TABLE attractions(
	a_id INT NOT NULL,
	descrpt VARCHAR(200) NOT NULL,
	startHour VARCHAR(100) NOT NULL,
	endHour VARCHAR(100) NOT NULL,
	admission NUMERIC(5,2) NOT NULL,
	CONSTRAINT attractions_pk PRIMARY KEY (a_id),
	CONSTRAINT attractions_fk FOREIGN KEY (a_id)
	REFERENCES sites (id)
);

INSERT INTO attractions
(a_id, descrpt, startHour, endHour, admission)
VALUES(3, 'This museum has the biggest mammals specimen collection bla bla bla ....', '10:00', '22:00', 23);

CREATE TABLE movies(
	m_id INT NOT NULL,
	theatre VARCHAR(200) NOT NULL,
	cost MONEY NOT NULL,
	yr INT NOT NULL,
	director VARCHAR(200) NOT NULL,
	lang VARCHAR(100) NOT NULL,
	rating INT NOT NULL,
	CONSTRAINT chk_rating_movies CHECK(rating <= 10),
	CONSTRAINT movies_pk PRIMARY KEY (m_id),
	CONSTRAINT movies_fk FOREIGN KEY (m_id)
	REFERENCES sites (id)
);

INSERT INTO movies VALUES(2,'Cineplex Brampton',15.00,2024,'Walid Belal','French',2);

CREATE TABLE users(
	userId INT NOT NULL,
	userName VARCHAR(50) NOT NULL, 
	firstName VARCHAR(100) NOT NULL, 
	lastName VARCHAR(100) NOT NULL, 
	profileImage VARCHAR(200),
	CONSTRAINT users_pk PRIMARY KEY (userId)
);

INSERT INTO users
(userId, userName, firstName, lastName, profileImage)
VALUES(1, 'MisSon', 'Misha', 'Sondhi', 'usr01.png');
INSERT INTO users
(userId, userName, firstName, lastName, profileImage)
VALUES(2, 'EbeDan', 'Ebenzer', 'Daniel', 'usr02.png');
INSERT INTO users
(userId, userName, firstName, lastName, profileImage)
VALUES(3, 'YeoPark', 'Yeomnmi', 'Park', 'usr03.png');
INSERT INTO users
(userId, userName, firstName, lastName, profileImage)
VALUES(4, 'BinSh', 'Binod', 'Shaestra', 'usr03.png');

CREATE TABLE restaurants(
	r_id INT NOT NULL,
	rating INT NOT NULL,
	maxPrice MONEY NOT NULL,
	minPrice MONEY NOT NULL,
	CONSTRAINT chk_rating_restaurants CHECK(rating <= 10),
	CONSTRAINT restaurants_pk PRIMARY KEY(r_id),
	CONSTRAINT restaurants_fk FOREIGN KEY(r_id)
	REFERENCES sites(id)
);

INSERT INTO restaurants
(r_id, rating, maxPrice, minPrice)
VALUES(4, 9, 75.00, 35.00);

CREATE TABLE reviews_movies(
	id INT NOT NULL,
	reviewerUserId INT NOT NULL,
	descrpt VARCHAR(200) NOT NULL,
	rating INT NOT NULL,
	CONSTRAINT chk_rating_reviews_1 CHECK(rating <= 10),
	CONSTRAINT reviews_pk_1 PRIMARY KEY (id,reviewerUserId),
	CONSTRAINT review_fk_1 FOREIGN KEY (id)
	REFERENCES movies (m_id),
	CONSTRAINT review_fk_2 FOREIGN KEY (reviewerUserId)
	REFERENCES users (userId)
);

CREATE TABLE reviews_restaurants(
	id INT NOT NULL,
	reviewerUserId INT NOT NULL,
	descrpt VARCHAR(200) NOT NULL,
	rating INT NOT NULL,
	CONSTRAINT chk_rating_reviews_2 CHECK(rating <= 10),
	CONSTRAINT reviews_pk_2 PRIMARY KEY (id,reviewerUserId),
	CONSTRAINT review_fk_3 FOREIGN KEY (id)
	REFERENCES restaurants (r_id),
	CONSTRAINT review_fk_4 FOREIGN KEY (reviewerUserId)
	REFERENCES users (userId)
);

INSERT INTO reviews_movies
(id, reviewerUserId, descrpt, rating)
VALUES(2, 3, 'Good movie', 9);

INSERT INTO reviews_restaurants
(id, reviewerUserId, descrpt, rating)
VALUES(4, 1, 'I received exceptional service at the restaurant', 10);

CREATE TABLE likes_restaurants(
	id INT NOT NULL,
	reviewerUserId INT NOT NULL,
	likeUserId INT NOT NULL,
	dateOfLike VARCHAR(10) NOT NULL,
	CONSTRAINT likes_pk_1 PRIMARY KEY(id, reviewerUserId, likeUserId),
	CONSTRAINT likes_fk_1 FOREIGN KEY(id,reviewerUserId)
	REFERENCES reviews_restaurants (id,reviewerUserId),
	CONSTRAINT likes_fk_2 FOREIGN KEY(likeUserId)
	REFERENCES users (userId)
);

INSERT INTO likes_restaurants VALUES(4,1,2,'2018-31-03');

CREATE TABLE likes_movies(
	id INT NOT NULL,
	reviewerUserId INT NOT NULL,
	likeUserId INT NOT NULL,
	dateOfLike VARCHAR(10) NOT NULL,
	CONSTRAINT likes_pk_2 PRIMARY KEY(id, reviewerUserId, likeUserId),
	CONSTRAINT likes_fk_3 FOREIGN KEY(id,reviewerUserId)
	REFERENCES reviews_movies (id,reviewerUserId),
	CONSTRAINT likes_fk_4 FOREIGN KEY(likeUserId)
	REFERENCES users (userId)
);

INSERT INTO likes_movies VALUES(2,3,4,'2018-23-09');

CREATE TABLE showTimes(
	m_id INT NOT NULL,
	startTime VARCHAR(10) NOT NULL,
	CONSTRAINT showTimes_pk PRIMARY KEY(m_id, startTime),
	CONSTRAINT showTimes_fk FOREIGN KEY(m_id)
	REFERENCES movies(m_id)
);

INSERT INTO showTimes VALUES(2,'9:00');
INSERT INTO showTimes VALUES(2,'12:00');
INSERT INTO showTimes VALUES(2,'15:00');
INSERT INTO showTimes VALUES(2,'18:00');

CREATE TABLE promotions(
	m_id INT NOT NULL,
	r_id INT NOT NULL,
	a_id INT NOT NULL,
	price MONEY NOT NULL,
	CONSTRAINT chk_price_promotions CHECK(price = 45.00),
	CONSTRAINT promotions_pk PRIMARY KEY(m_id,r_id,a_id),
	CONSTRAINT promotions_fk_1 FOREIGN KEY(m_id)
	REFERENCES movies (m_id),
	CONSTRAINT promotions_fk_2 FOREIGN KEY(r_id)
	REFERENCES restaurants (r_id),
	CONSTRAINT promotions_fk_3 FOREIGN KEY(a_id)
	REFERENCES attractions (a_id)
);

INSERT INTO promotions
(m_id, r_id, a_id, price)
VALUES(2, 4, 3, 45.00);

CREATE TABLE communityDiscussions(
	topicId INT NOT NULL,
	topicTitle VARCHAR(200) NOT NULL,
	authorUserId INT NOT NULL,
	CONSTRAINT communityDiscussions_pk PRIMARY KEY (topicId),
	CONSTRAINT communityDiscussions_fk FOREIGN KEY (authorUserId)
	REFERENCES users (userId)
);

INSERT INTO communityDiscussions
(topicId, topicTitle, authorUserId)
VALUES(1, 'What do you like about Toronto?', 2);

CREATE TABLE comments(
	topicId INT NOT NULL,
	commenterUserId INT NOT NULL,
	tmStamp VARCHAR(50) NOT NULL,
	descrpt VARCHAR(200) NOT NULL,
	CONSTRAINT comments_pk PRIMARY KEY (topicId, commenterUserId, tmStamp),
	CONSTRAINT comments_fk_1 FOREIGN KEY (commenterUserId)
	REFERENCES users (userId),
	CONSTRAINT comments_fk_2 FOREIGN KEY (topicId)
	REFERENCES communityDiscussions(topicId)
);

INSERT INTO comments
(topicId, commenterUserId, tmStamp, descrpt)
VALUES(1, 2, '2018-12-09 20:00:00', 'I like the weather');

INSERT INTO comments
(topicId, commenterUserId, tmStamp, descrpt)
VALUES(1, 4, '2018-12-09 22:32:43', 'I like the island');

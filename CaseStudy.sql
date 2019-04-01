USE section13;

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

CREATE TABLE sites(
	id INT NOT NULL,
	title VARCHAR(200) NOT NULL,
	CONSTRAINT sites_pk PRIMARY KEY (id), 
	CONSTRAINT sites_fk FOREIGN KEY (title)
	REFERENCES details (title)
);

--exec sp_help details;
--exec sp_help sites;

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

CREATE TABLE movies(
	m_id INT NOT NULL,
	theatre VARCHAR(200) NOT NULL,
	cost NUMERIC(5,2) NOT NULL,
	yr NUMERIC(4) NOT NULL,
	director VARCHAR(200) NOT NULL,
	lang VARCHAR(100) NOT NULL,
	rating NUMERIC(2,2) NOT NULL,
	CONSTRAINT chk_rating_movies CHECK(rating <= 10),
	CONSTRAINT movies_pk PRIMARY KEY (m_id),
	CONSTRAINT movies_fk FOREIGN KEY (m_id)
	REFERENCES sites (id)
);

CREATE TABLE users(
	userId INT NOT NULL,
	userName VARCHAR(50) NOT NULL, 
	firstName VARCHAR(100) NOT NULL, 
	lastName VARCHAR(100) NOT NULL, 
	profileImage VARCHAR(200),
	CONSTRAINT users_pk PRIMARY KEY (userId)
);

CREATE TABLE restaurants(
	r_id INT NOT NULL,
	rating NUMERIC(2,2) NOT NULL,
	maxPrice NUMERIC(5,2) NOT NULL,
	minPrice NUMERIC(5,2) NOT NULL,
	CONSTRAINT chk_rating_restaurants CHECK(rating <= 10),
	CONSTRAINT restaurants_pk PRIMARY KEY(r_id),
	CONSTRAINT restaurants_fk FOREIGN KEY(r_id)
	REFERENCES sites(id)
);

CREATE TABLE reviews(
	id INT NOT NULL,
	reviewerUserId INT NOT NULL,
	descrpt VARCHAR(200) NOT NULL,
	rating NUMERIC(2,2) NOT NULL,
	CONSTRAINT chk_rating_reviews CHECK(rating <= 10),
	CONSTRAINT reviews_pk PRIMARY KEY (id,reviewerUserId),
	CONSTRAINT review_fk_1 FOREIGN KEY (id)
	REFERENCES movies (m_id),
	CONSTRAINT review_fk_2 FOREIGN KEY (id)
	REFERENCES restaurants (r_id),
	CONSTRAINT review_fk_3 FOREIGN KEY (reviewerUserId)
	REFERENCES users (userId)
);

CREATE TABLE likes(
	id INT NOT NULL,
	reviewerUserId INT NOT NULL,
	likeUserId INT NOT NULL,
	dateOfLike NUMERIC(4) NOT NULL,
	CONSTRAINT likes_pk PRIMARY KEY(id, reviewerUserId, likeUserId),
	CONSTRAINT likes_fk_1 FOREIGN KEY(id,reviewerUserId)
	REFERENCES reviews (id,reviewerUserId),
	CONSTRAINT likes_fk_2 FOREIGN KEY(likeUserId)
	REFERENCES users (userId)
);

CREATE TABLE showTimes(
	m_id INT NOT NULL,
	startTime VARCHAR(10) NOT NULL,
	CONSTRAINT showTimes_pk PRIMARY KEY(m_id, startTime),
	CONSTRAINT showTimes_fk FOREIGN KEY(m_id)
	REFERENCES movies(m_id)
);

CREATE TABLE promotions(
	m_id INT NOT NULL,
	r_id INT NOT NULL,
	a_id INT NOT NULL,
	price NUMERIC(2,2) NOT NULL,
	CONSTRAINT chk_price_promotions CHECK(price = 45.00),
	CONSTRAINT promotions_pk PRIMARY KEY(m_id,r_id,a_id),
	CONSTRAINT promotions_fk_1 FOREIGN KEY(m_id)
	REFERENCES movies (m_id),
	CONSTRAINT promotions_fk_2 FOREIGN KEY(r_id)
	REFERENCES restaurants (r_id),
	CONSTRAINT promotions_fk_3 FOREIGN KEY(a_id)
	REFERENCES attractions (a_id)
);

CREATE TABLE communityDiscussions(
	topicId INT NOT NULL,
	topicTitle VARCHAR(200) NOT NULL,
	authorUserId INT NOT NULL,
	CONSTRAINT communityDiscussions_pk PRIMARY KEY (topicId),
	CONSTRAINT communityDiscussions_fk FOREIGN KEY (authorUserId)
	REFERENCES users (userId)
);

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

drop table comments;
drop table communityDiscussions;
drop table promotions;
drop table showTimes;
drop table likes;
drop table reviews;
drop table restaurants;
drop table users;
drop table movies;
drop table attractions;
drop table evnts;
drop table sites;
drop table details;
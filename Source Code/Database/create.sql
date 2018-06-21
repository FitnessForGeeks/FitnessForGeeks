create database if not exists FitnessForGeeks;
use FitnessForGeeks;

CREATE TABLE accounts (
    id INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(20) NOT NULL UNIQUE,
    password VARCHAR(64) NOT NULL,
    firstName VARCHAR(15),
    lastName VARCHAR(20),
    isMale BOOLEAN,
    email VARCHAR(320) NOT NULL UNIQUE,
    birthDate DATE,
    weight DOUBLE(5 , 2),
    height INT(3),
    isVerified BOOLEAN NOT NULL DEFAULT FALSE,
    authKey VARCHAR(64) NOT NULL UNIQUE,
    description VARCHAR(255),
    createdAt timestamp
);

CREATE TABLE eatenRecipes (
    id INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    accountId INT(10) NOT NULL REFERENCES accounts (id),
    date date NOT NULL,
    recipeId INT(10) NOT NULL
);

CREATE TABLE recipes (
    id INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    accountId INT(10) REFERENCES accounts(id),
    title VARCHAR(30) NOT NULL UNIQUE,
    description varchar(255),
    directions text,
    ingredients text,
    public boolean default false,
    calories INT(5),
    reviewCount int(5) not null default 0,
    createdAt timestamp,
    avgRating double(3, 2) default 0
);

truncate table eatenRecipes;

create table reviews(
	id INT(10) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    accountId INT(10) REFERENCES accounts(id),
    recipeId INT(10) references recipes(id),
    text text not null,
    rating double(3, 2) not null check(rating >= 0 and rating <= 5),
    createdAt timestamp not null
);

delimiter $$
create function insertReview(
	accountId int(10),
    recipeId int(10),
    text text,
    rating double(3, 2)
)
returns int(10)
deterministic
begin
	declare id int(10) default -1;
	insert into reviews(
		accountId,
		recipeId,
		text,
		rating,
		createdAt
	)
	values(
		accountId,
		recipeId,
		text,
		rating,
		current_timestamp()
	);
    set id = last_insert_id();
    update recipes
	set avgRating = ((avgRating * reviewCount) + rating)/(reviewCount + 1), reviewCount = reviewCount + 1
	where recipes.id = recipeId;
    return id;
end $$
delimiter ;

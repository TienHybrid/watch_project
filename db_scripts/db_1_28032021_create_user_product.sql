CREATE TABLE "User" (
	id serial NOT NULL,
	username varchar(60) NOT NULL,
	fullname varchar(60) NULL,
	email varchar(255) NOT NULL,
	"password" varchar(255) NOT NULL,
  	address varchar NULL,
  	phone_number VARCHAR(11) NULL,
  	avatar_url VARCHAR(256) NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT user_pk PRIMARY KEY (id)
);

CREATE TABLE Staff (
	id serial NOT NULL,
	username varchar(60) NOT NULL,
	fullname varchar(60) NULL,
	email varchar(255) NOT NULL,
	"password" varchar(255) NOT NULL,
  	address varchar NULL,
  	phone_number VARCHAR(11) NULL,
  	avatar_url VARCHAR(256) NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT staff_pk PRIMARY KEY (id)
);

CREATE TABLE Category(
	"id" serial NOT NULL,
	"name" varchar(60) NOT NULL,
	image_url varchar null,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT category_pk PRIMARY KEY (id)
);


CREATE TABLE Product(
	"id" serial NOT NULL,
	"name" varchar(60) NOT NULL,
	price INTEGER not NULL DEFAULT 0,
  	quantity INTEGER NOT NULL DEFAULT 0,
  	category_id INTEGER NULL,
  	image_url VARCHAR[],
  	slug varchar null,
  	description varchar null,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT product_pk PRIMARY KEY (id),
  	CONSTRAINT category_product_fk FOREIGN KEY (category_id) REFERENCES Category("id")
);
alter table Product
      ALTER column image_url SET DEFAULT array[]::varchar[];
CREATE TABLE Voucher (
	id serial NOT NULL,
	name varchar(60) NOT NULL,
	type varchar(60) NOT NULL,
	begin_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	end_date timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT voucher_pk PRIMARY KEY (id)
);

CREATE TABLE Place (
	id serial NOT NULL,
	name varchar(60) NOT NULL,
	short_name varchar(60) NOT NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT place_pk PRIMARY KEY (id)
);

CREATE TABLE Stock (
	id serial NOT NULL,
	name varchar(60) NOT NULL,
    place_id integer null,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT stock_pk PRIMARY KEY (id),
	CONSTRAINT stock_place_fk FOREIGN KEY (place_id) REFERENCES Place("id")
);

CREATE TABLE StockInProduct (
	id serial NOT NULL,
	name varchar(60) NOT NULL,
    stock_id integer null,
    product_id integer null,
    quantity int not null,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT stock_in_product_pk PRIMARY KEY (id),
	CONSTRAINT stock_fk FOREIGN KEY (stock_id) REFERENCES Stock("id"),
	CONSTRAINT product_fk FOREIGN KEY (product_id) REFERENCES Product("id")
);
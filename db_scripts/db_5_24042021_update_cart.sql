CREATE TABLE Cart (
	id serial NOT NULL,
    user_id integer NOT NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT cart_pk PRIMARY KEY (id),
	CONSTRAINT cart_user_fk FOREIGN KEY (user_id) REFERENCES "User"("id")
);

CREATE TABLE CartProduct (
	id serial NOT NULL,
    stock_id integer NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL default 0,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT cart_product_pk PRIMARY KEY (id),
	CONSTRAINT cart_product_stock_fk FOREIGN KEY (stock_id) REFERENCES Stock("id"),
	CONSTRAINT cart_in_product_fk FOREIGN KEY (product_id) REFERENCES Product("id"),
	CONSTRAINT cart_product_fk FOREIGN KEY (cart_id) REFERENCES Cart("id")
);


CREATE TABLE "Transaction" (
	id serial NOT NULL,
    user_id integer NOT NULL,
    user_name varchar(60) NOT NULL default '',
    email varchar(60) NOT NULL default '',
    phone_number varchar(11) NOT NULL default '',
    address text NOT NULL default '',
    content text NOT NULL default '',
    status integer not null default 0,
    shipping_method smallint not null default 0,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT transaction_pk PRIMARY KEY (id),
	CONSTRAINT transaction_user_fk FOREIGN KEY (user_id) REFERENCES "User"("id")
);

    CREATE TABLE TransactionProduct (
	id serial NOT NULL,
    stock_id integer NOT NULL,
    transactionc_id integer NOT NULL,
    product_id integer NOT NULL,
    quantity integer NOT NULL default 0,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT transaction_product_pk PRIMARY KEY (id),
	CONSTRAINT transaction_product_stock_fk FOREIGN KEY (stock_id) REFERENCES Stock("id"),
	CONSTRAINT transaction_in_product_fk FOREIGN KEY (product_id) REFERENCES Product("id"),
	CONSTRAINT transaction_product_fk FOREIGN KEY (transactionc_id) REFERENCES "Transaction"("id")
);


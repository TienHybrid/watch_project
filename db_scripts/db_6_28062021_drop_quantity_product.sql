alter table product drop column quantity;

CREATE TABLE Brand(
	"id" serial NOT NULL,
	"name" varchar(60) NOT NULL,
	image_url varchar null,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT brand_pk PRIMARY KEY (id)
);

Alter table product add column brand_id int default 1;
Alter table product add CONSTRAINT fk_branch_product  FOREIGN KEY (brand_id) REFERENCES Brand (id);

CREATE TABLE VoucherInUser (
	id serial NOT NULL,
    user_id integer null,
    voucher_id integer null,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT voucher_in_user_pk PRIMARY KEY (id),
	CONSTRAINT user_fk FOREIGN KEY (user_id) REFERENCES "User"("id"),
	CONSTRAINT voucher_fk FOREIGN KEY (voucher_id) REFERENCES Voucher("id")
);

CREATE TABLE PlaceMaster (
	id serial NOT NULL,
	name varchar(60) NOT NULL,
	short_name varchar(60) NOT NULL,
	created_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	is_deleted bool NOT NULL DEFAULT false,
	CONSTRAINT place_master_pk PRIMARY KEY (id)
);

Alter table "user" add column place_id int default null;
Alter table "user" add CONSTRAINT fk_user_place  FOREIGN KEY (place_id) REFERENCES PlaceMaster (id);

Alter table "Transaction" add column voucher_id int default null;
Alter table "Transaction" add CONSTRAINT fk_transaction_voucher  FOREIGN KEY (voucher_id) REFERENCES Voucher(id);

Alter table "Transaction" add column discount int default 0;
Alter table "Transaction" add column shipping_fee int default 0;
Alter table "Transaction" add column subtotal int default 0;
Alter table "Transaction" add column total int default 0;

Alter table product add column old_price int default 0;

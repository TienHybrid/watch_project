ALTER TABLE staff ADD UNIQUE (email);
ALTER TABLE staff ADD UNIQUE (username);

ALTER TABLE "User" ADD UNIQUE (email);
ALTER TABLE "User" ADD UNIQUE (username);

ALTER TABLE product ADD UNIQUE (slug);

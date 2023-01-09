CREATE TABLE products (
    id serial PRIMARY KEY,
    name varchar(512), NOT NULL, CHECK (name != ''),
    price numeric(10,2) NOT NULL CHECK (price > 0),
);


CREATE TABLE customers (
    id serial PRIMARY KEY,
    name varchar(256), NOT NULL, CHECK (name != ''),
    address varchar(512), NOT NULL, CHECK (name != ''),
    phone_number varchar(15), CHECK (phone_number = NOT LIKE '%[^0-9]%')
);


CREATE TABLE orders (
    id serial PRIMARY KEY,
    products_id int REFERENCES products(id),
    customer_id int REFERENCES customers(id),
    quantity_plan int CHECK (product_quantity > 0),
    signed_at timestamp DEFAULT current_timestamp,
    contract_number serial PRIMARY KEY,
);


CREATE TABLE shipments (
    id serial PRIMARY KEY,
    shipped_at timestamp DEFAULT current_timestamp
    order_id int REFERENCES orders(id)
);

CREATE TABLE products_to shipments (
    product_id int REFERENCES products(id),
    shipment_id int REFERENCES shipments(id),
    shipped_quantity int CHECK (shipped_quantity > 0),
    PRIMARY KEY (product_id, shipment_id)
);
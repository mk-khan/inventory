﻿DROP SCHEMA IF EXISTS inventory CASCADE;

CREATE SCHEMA inventory;

--TODO: CREATE UNIQUE INDEXES

CREATE TABLE inventory.units
(
    unit_id                                 SERIAL PRIMARY KEY,
    unit_code                               national character varying(24) NOT NULL,
    unit_name                               national character varying(500) NOT NULL,    
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.compound_units
(
    compound_unit_id                        SERIAL PRIMARY KEY,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    value                                   smallint NOT NULL DEFAULT(0) CHECk(value > 0),
    compare_unit_id                         integer NOT NULL REFERENCES inventory.units,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.supplier_types
(
    supplier_type_id                        SERIAL PRIMARY KEY,
    supplier_type_code                      national character varying(24) NOT NULL,
    supplier_type_name                      national character varying(500) NOT NULL,
	account_id								integer NOT NULL REFERENCES finance.accounts,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.suppliers
(
    supplier_id                             SERIAL PRIMARY KEY,
    supplier_code                           national character varying(24) NOT NULL,
    supplier_name                           national character varying(500) NOT NULL,
	supplier_type_id						integer NOT NULL REFERENCES inventory.supplier_types,
	account_id								integer NOT NULL REFERENCES finance.accounts,
	currency_code							national character varying(12) NOT NULL REFERENCES core.currencies,
    company_name                            national character varying(1000),
    company_address_line_1                  national character varying(128),   
    company_address_line_2                  national character varying(128),
    company_street                          national character varying(1000),
    company_city                            national character varying(1000),
    company_state                           national character varying(1000),
    company_country                         national character varying(1000),
    company_po_box                          national character varying(1000),
    company_zipcode                         national character varying(1000),
    company_phone_numbers                   national character varying(1000),
    company_fax                             national character varying(100),
    logo                                    public.photo,
    contact_first_name                      national character varying(100),
    contact_middle_name                     national character varying(100),
    contact_last_name                       national character varying(100),
    contact_address_line_1                  national character varying(128),   
    contact_address_line_2                  national character varying(128),
    contact_street                          national character varying(100),
    contact_city                            national character varying(100),
    contact_state                           national character varying(100),
    contact_country                         national character varying(100),
    contact_po_box                          national character varying(100),
    contact_zipcode                         national character varying(100),
    contact_phone_numbers                   national character varying(100),
    contact_fax                             national character varying(100),
    photo                                   public.photo,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.customer_types
(
    customer_type_id                        SERIAL PRIMARY KEY,
    customer_type_code                      national character varying(24) NOT NULL,
    customer_type_name                      national character varying(500) NOT NULL,
	account_id								integer NOT NULL REFERENCES finance.accounts,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.customers
(
    customer_id                             SERIAL PRIMARY KEY,
    customer_code                           national character varying(24) NOT NULL,
    customer_name                           national character varying(500) NOT NULL,
    customer_type_id                        integer NOT NULL REFERENCES inventory.customer_types,
	account_id								integer NOT NULL REFERENCES finance.accounts,
	currency_code							national character varying(12) NOT NULL REFERENCES core.currencies,
    company_name                            national character varying(1000),
    company_address_line_1                  national character varying(128),   
    company_address_line_2                  national character varying(128),
    company_street                          national character varying(1000),
    company_city                            national character varying(1000),
    company_state                           national character varying(1000),
    company_country                         national character varying(1000),
    company_po_box                          national character varying(1000),
    company_zipcode                         national character varying(1000),
    company_phone_numbers                   national character varying(1000),
    company_fax                             national character varying(100),
    logo                                    public.photo,
    contact_first_name                      national character varying(100),
    contact_middle_name                     national character varying(100),
    contact_last_name                       national character varying(100),
    contact_address_line_1                  national character varying(128),   
    contact_address_line_2                  national character varying(128),
    contact_street                          national character varying(100),
    contact_city                            national character varying(100),
    contact_state                           national character varying(100),
    contact_country                         national character varying(100),
    contact_po_box                          national character varying(100),
    contact_zipcode                         national character varying(100),
    contact_phone_numbers                   national character varying(100),
    contact_fax                             national character varying(100),
    photo                                   public.photo,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.item_groups
(
    item_group_id                           SERIAL PRIMARY KEY,
    item_group_code                         national character varying(24) NOT NULL,
    item_group_name                         national character varying(500) NOT NULL,
    exclude_from_purchase                   boolean NOT NULL DEFAULT(false),
    exclude_from_sales                      boolean NOT NULL DEFAULT(false),    
    sales_account_id                        bigint NOT NULL REFERENCES finance.accounts,
    sales_discount_account_id               bigint NOT NULL REFERENCES finance.accounts,
    sales_return_account_id                 bigint NOT NULL REFERENCES finance.accounts,
    purchase_account_id                     bigint NOT NULL REFERENCES finance.accounts,
    purchase_discount_account_id            bigint NOT NULL REFERENCES finance.accounts,
    inventory_account_id                    bigint NOT NULL REFERENCES finance.accounts,
    cost_of_goods_sold_account_id           bigint NOT NULL REFERENCES finance.accounts,    
    parent_item_group_id                    integer REFERENCES inventory.item_groups(item_group_id),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.brands
(
    brand_id                                SERIAL PRIMARY KEY,
    brand_code                              national character varying(24) NOT NULL,
    brand_name                              national character varying(500) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.item_types
(
    item_type_id                            SERIAL PRIMARY KEY,
    item_type_code                          national character varying(12) NOT NULL,
    item_type_name                          national character varying(50) NOT NULL,
	is_component							boolean NOT NULL DEFAULT(false),
    audit_user_id                           integer NULL REFERENCES account.users(user_id),
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE UNIQUE INDEX item_type_item_type_code_uix
ON inventory.item_types(UPPER(item_type_code));


CREATE UNIQUE INDEX item_type_item_type_name_uix
ON inventory.item_types(UPPER(item_type_name));


CREATE TABLE inventory.items
(
    item_id                                 SERIAL PRIMARY KEY,
    item_code                               national character varying(24) NOT NULL,
    item_name                               national character varying(500) NOT NULL,
    barcode                                 national character varying(100), --UNIQUE
    item_group_id                           integer NOT NULL REFERENCES inventory.item_groups,
	item_type_id							integer NOT NULL REFERENCES inventory.item_types,
    brand_id                                integer REFERENCES inventory.brands,
    preferred_supplier_id                   integer REFERENCES inventory.suppliers,
    lead_time_in_days                       integer,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    hot_item                                boolean NOT NULL DEFAULT(false),
    cost_price                              public.decimal_strict2,
	cost_price_includes_tax					boolean NOT NULL DEFAULT(false),
    selling_price                           public.decimal_strict2,
	selling_price_includes_tax				boolean NOT NULL DEFAULT(false),
    reorder_level                           public.integer_strict2 NOT NULL DEFAULT(0),
    reorder_quantity                        public.integer_strict2 NOT NULL DEFAULT(0),
	reorder_unit_id                         integer NOT NULL REFERENCES inventory.units,
    maintain_inventory                      boolean NOT NULL DEFAULT(true),
    photo                                   public.photo,
    allow_sales                             boolean NOT NULL DEFAULT(true),
    allow_purchase                          boolean NOT NULL DEFAULT(true),
    is_variant_of                           integer REFERENCES inventory.items,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);


CREATE TABLE inventory.store_types
(
    store_type_id                           SERIAL PRIMARY KEY,
    store_type_code                         national character varying(12) NOT NULL,
    store_type_name                         national character varying(50) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.stores
(
    store_id                                SERIAL PRIMARY KEY,
    store_code                              national character varying(24) NOT NULL,
    store_name                              national character varying(100) NOT NULL,
    store_type_id                           integer NOT NULL REFERENCES inventory.store_types,
	office_id								integer NOT NULL REFERENCES core.offices,
    default_account_id_for_checks           integer NOT NULL REFERENCES finance.accounts,
    default_cash_account_id                 integer NOT NULL REFERENCES finance.accounts,
    default_cash_repository_id              integer NOT NULL REFERENCES finance.cash_repositories,
    address_line_1                          national character varying(128),   
    address_line_2                          national character varying(128),
    street                                  national character varying(50),
    city                                    national character varying(50),
    state                                   national character varying(50),
    country                                 national character varying(50),
    phone                                   national character varying(50),
    fax                                     national character varying(50),
    cell                                    national character varying(50),
    allow_sales                             boolean NOT NULL DEFAULT(true),	
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.counters
(
    counter_id                              SERIAL PRIMARY KEY,
    counter_code                            national character varying(12) NOT NULL,
    counter_name                            national character varying(100) NOT NULL,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.shippers
(
    shipper_id                              SERIAL PRIMARY KEY,
    shipper_code                            national character varying(24),
    company_name                            national character varying(128) NOT NULL,
    shipper_name                            national character varying(150),
    po_box                                  national character varying(128),
    address_line_1                          national character varying(128),   
    address_line_2                          national character varying(128),
    street                                  national character varying(50),
    city                                    national character varying(50),
    state                                   national character varying(50),
    country                                 national character varying(50),
    phone                                   national character varying(50),
    fax                                     national character varying(50),
    cell                                    national character varying(50),
    email                                   national character varying(128),
    url                                     national character varying(50),
    contact_person                          national character varying(50),
    contact_po_box                          national character varying(128),
    contact_address_line_1                  national character varying(128),   
    contact_address_line_2                  national character varying(128),
    contact_street                          national character varying(50),
    contact_city                            national character varying(50),
    contact_state                           national character varying(50),
    contact_country                         national character varying(50),
    contact_email                           national character varying(128),
    contact_phone                           national character varying(50),
    contact_cell                            national character varying(50),
    factory_address                         national character varying(250),
    pan_number                              national character varying(50),
    sst_number                              national character varying(50),
    cst_number                              national character varying(50),
    account_id                              bigint NOT NULL REFERENCES finance.accounts(account_id),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.checkouts
(
    checkout_id                             BIGSERIAL PRIMARY KEY,
	value_date								date NOT NULL,
	book_date								date NOT NULL,
	transaction_master_id					bigint NOT NULL REFERENCES finance.transaction_master,
    transaction_timestamp                   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
    transaction_book                        national character varying(100) NOT NULL, --SALES, PURCHASE, INVENTORY TRANSFER, DAMAGE
	discount								public.decimal_strict2 DEFAULT(0),
    posted_by                               integer NOT NULL REFERENCES account.users,
    /*LOOKUP FIELDS, ONLY TO SPEED UP THE QUERY */
    office_id                               integer NOT NULL REFERENCES core.offices,
    /*LOOKUP FIELDS */    
    cancelled                               boolean NOT NULL DEFAULT(false),
	cancellation_reason						text,
	shipper_id								integer REFERENCES inventory.shippers,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);


CREATE TABLE inventory.checkout_details
(
    checkout_detail_id                      BIGSERIAL PRIMARY KEY,
    checkout_id                             bigint NOT NULL REFERENCES inventory.checkouts,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
	value_date								date NOT NULL,
	book_date								date NOT NULL,
    transaction_type                        national character varying(2) NOT NULL
                                            CHECK(transaction_type IN('Dr', 'Cr')),
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    price                                   public.money_strict NOT NULL,
    discount                                public.money_strict2 NOT NULL DEFAULT(0),    
    cost_of_goods_sold                      public.money_strict2 NOT NULL DEFAULT(0),
    shipping_charge                         public.money_strict2 NOT NULL DEFAULT(0),    
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    quantity                                public.decimal_strict NOT NULL,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           numeric NOT NULL,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW())
);

CREATE TABLE inventory.inventory_transfer_requests
(
    inventory_transfer_request_id           BIGSERIAL PRIMARY KEY,
    office_id                               integer NOT NULL REFERENCES core.offices,
    user_id                                 integer NOT NULL REFERENCES account.users,
    store_id                                integer NOT NULL REFERENCES inventory.stores,
    request_date                            date NOT NULL,
    transaction_timestamp                   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
    reference_number                        national character varying(24),
    statement_reference                     national character varying(500),
    authorized                              boolean NOT NULL DEFAULT(false),
    authorized_by_user_id                   integer REFERENCES account.users,
    authorized_on                           TIMESTAMP WITH TIME ZONE,
    authorization_reason                    national character varying(500),
    rejected                                boolean NOT NULL DEFAULT(false),
    rejected_by_user_id                     integer REFERENCES account.users,
    rejected_on                             TIMESTAMP WITH TIME ZONE,
    rejection_reason                        national character varying(500),
    received                                boolean NOT NULL DEFAULT(false),
    received_by_user_id                     integer REFERENCES account.users,
    received_on                             TIMESTAMP WITH TIME ZONE,
    receipt_memo                            national character varying(500),
    delivered                               boolean NOT NULL DEFAULT(false),
    delivered_by_user_id                    integer REFERENCES account.users,
    delivered_on                            TIMESTAMP WITH TIME ZONE,
    delivery_memo                           national character varying(500),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)    
);

CREATE TABLE inventory.inventory_transfer_request_details
(
    inventory_transfer_request_detail_id    BIGSERIAL PRIMARY KEY,
    inventory_transfer_request_id           bigint NOT NULL REFERENCES inventory.inventory_transfer_requests,
    request_date                            date NOT NULL,
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    quantity                                public.decimal_strict2 NOT NULL,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           public.decimal_strict2 NOT NULL
);

CREATE TABLE inventory.inventory_transfer_deliveries
(
    inventory_transfer_delivery_id          BIGSERIAL PRIMARY KEY,
    inventory_transfer_request_id           bigint NOT NULL REFERENCES inventory.inventory_transfer_requests,
    office_id                               integer NOT NULL REFERENCES core.offices,
    user_id                                 integer NOT NULL REFERENCES account.users,
    destination_store_id                    integer NOT NULL REFERENCES inventory.stores,
    delivery_date                           date NOT NULL,
    transaction_timestamp                   TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT(NOW()),
    reference_number                        national character varying(24),
    statement_reference                     national character varying(500),
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);


CREATE TABLE inventory.inventory_transfer_delivery_details
(
    inventory_transfer_delivery_detail_id   BIGSERIAL PRIMARY KEY,
    inventory_transfer_delivery_id          bigint NOT NULL REFERENCES inventory.inventory_transfer_deliveries,
    request_date                            date NOT NULL,
    item_id                                 integer NOT NULL REFERENCES inventory.items,
    quantity                                public.decimal_strict2 NOT NULL,
    unit_id                                 integer NOT NULL REFERENCES inventory.units,
    base_unit_id                            integer NOT NULL REFERENCES inventory.units,
    base_quantity                           public.decimal_strict2 NOT NULL
);


CREATE TABLE inventory.attributes
(
	attribute_id                            SERIAL NOT NULL PRIMARY KEY,
	attribute_code                          national character varying(12) NOT NULL UNIQUE,
	attribute_name                          national character varying(100) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.variants
(
	variant_id                              SERIAL NOT NULL PRIMARY KEY,
	variant_code                            national character varying(12) NOT NULL UNIQUE,
	variant_name                            national character varying(100) NOT NULL,
	attribute_id                            integer NOT NULL REFERENCES inventory.attributes,
	attribute_value                         national character varying(200) NOT NULL,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.item_variants
(
	item_variant_id                         SERIAL NOT NULL PRIMARY KEY,
	item_id                                 integer NOT NULL REFERENCES inventory.items,
	variant_id                              integer NOT NULL REFERENCES inventory.variants,
    audit_user_id                           integer REFERENCES account.users,
    audit_ts                                TIMESTAMP WITH TIME ZONE DEFAULT(NOW()),
	deleted									boolean DEFAULT(false)
);

CREATE TABLE inventory.inventory_setup
(
	office_id								integer NOT NULL PRIMARY KEY REFERENCES core.offices,
	inventory_system						national character varying(50) NOT NULL
											CHECK(inventory_system IN('Periodic', 'Perpetual')),
	cogs_calculation_method					national character varying(50) NOT NULL
											CHECK(cogs_calculation_method IN('FIFO', 'LIFO', 'MAVCO')),
	allow_multiple_opening_inventory		boolean NOT NULL DEFAULT(false),
	default_discount_account_id				integer NOT NULL REFERENCES finance.accounts
);

CREATE TYPE inventory.transfer_type
AS
(
    tran_type       national character varying(2),
    store_name      national character varying(50),
    item_code       national character varying(12),
    unit_name       national character varying(50),
    quantity        public.decimal_strict,
    rate            public.money_strict2
);

CREATE TYPE inventory.adjustment_type 
AS
(
    tran_type       national character varying(2),
    item_code       national character varying(12),
    unit_name       national character varying(50),
    quantity        public.decimal_strict
);


CREATE TYPE inventory.checkout_detail_type 
AS
(
    store_id            integer,
    item_id           	integer,
    quantity            public.decimal_strict,
    unit_id           	national character varying(50),
    price               public.money_strict,
    discount            public.money_strict2,
    shipping_charge     public.money_strict2
);


CREATE TYPE inventory.opening_stock_type
AS
(
    store_id            integer,
    item_id           	integer,
    quantity            public.decimal_strict,
    unit_id           	integer,
    price          		public.money_strict
);


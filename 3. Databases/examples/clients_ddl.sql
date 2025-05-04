CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    middle_name VARCHAR(255) DEFAULT '',
    full_name VARCHAR(255),
    code VARCHAR(255) NOT NULL,
    deleted_at TIMESTAMP,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    tax_years INTEGER[] DEFAULT '{}',
    suffix VARCHAR(255),
    account_name VARCHAR(255),
    firm_id BIGINT,
    state VARCHAR(255),
    quickbooks_state INTEGER DEFAULT 0 NOT NULL,
    current_sign_in_at TIMESTAMP,
    custom_fields JSONB DEFAULT '{}'::JSONB NOT NULL,
    tree_nodes_updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    archived_at TIMESTAMP,
    account_type INTEGER DEFAULT 0,
    company_name VARCHAR(255),
    stripe_customer_id VARCHAR(255),
    lead BOOLEAN DEFAULT FALSE
);

CREATE UNIQUE INDEX index_clients_on_account_name_and_firm_id_without_deleted 
    ON clients (account_name, firm_id)
    WHERE (deleted_at IS NULL);

CREATE UNIQUE INDEX index_clients_on_code_and_firm_id 
    ON clients (code, firm_id);

CREATE INDEX index_clients_on_code 
    ON clients (code);

CREATE INDEX index_clients_on_deleted_at 
    ON clients (deleted_at);

CREATE INDEX index_clients_on_firm_id 
    ON clients (firm_id);

ALTER TABLE clients
    ADD CONSTRAINT accounts_account_type_null CHECK (account_type IS NOT NULL);

require 'sequel'
require 'sequel/extensions/pg_hstore'
Sequel.extension :core_extensions
Sequel.extension(:pg_hstore, :pg_hstore_ops, :pg_array)
# DB.extend Sequel::Postgres::HStore::DatabaseMethods
# ROM.env.gateways[:default].connection.extension(:connection_validator)
# ROM.env.gateways[:default].connection.extension :pg_hstore

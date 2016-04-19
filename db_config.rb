require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'cheerup'
}

ActiveRecord::Base.establish_connection(options)

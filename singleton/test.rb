require_relative "database-connection-singleton"

db_connection = DatabaseConnectionSingleton.instance

puts db_connection.connected?.inspect

db_connection.connect

puts db_connection.connected?.inspect

db_connection.disconnect

puts db_connection.connected?.inspect

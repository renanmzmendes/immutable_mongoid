
if Rails.env.test?
  require 'database_cleaner'
  DatabaseCleaner.strategy = :truncation
end

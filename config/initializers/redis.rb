uri = URI.parse(
  ENV['REDIS_URL'] ||
  ENV['REDISCLOUD_URL'] ||
  'redis://localhost:6379/'
)
REDIS = Redis.new(url: uri)

require 'resque/server'
Resque.redis = REDIS

require 'redis'
# REDIS_CONFIG = YAML.load( File.open( Rails.root.join("config/redis.yml") ) ).symbolize_keys
# dflt = REDIS_CONFIG[:default].symbolize_keys
# cnfg = dflt.merge(REDIS_CONFIG[Rails.env.to_sym].symbolize_keys) if REDIS_CONFIG[Rails.env.to_sym]
# REDIS = Redis.new(cnfg)



HOST = 'redis'
PORT = 6379

REDIS = Redis.new(host: HOST, port: PORT)
puts "ADASDADADASDASDASDASD:::::#{REDIS.inspect}"
# puts REDIS

# #$redis_ns = Redis::Namespace.new(cnfg[:namespace], :redis => $redis) if cnfg[:namespace]

# # To clear out the db before each test
# # Redis.flushall if Rails.env = "test"

# REDIS = Redis.new

require 'redis'
# REDIS_CONFIG = YAML.load( File.open( Rails.root.join("config/redis.yml") ) ).symbolize_keys
# dflt = REDIS_CONFIG[:default].symbolize_keys
# cnfg = dflt.merge(REDIS_CONFIG[Rails.env.to_sym].symbolize_keys) if REDIS_CONFIG[Rails.env.to_sym]
# REDIS = Redis.new(cnfg)



HOST = '192.168.99.100'
PORT = 6379

REDIS = Redis.new(host: HOST, port: PORT)
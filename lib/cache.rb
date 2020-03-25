module Cache

  def self.core
    @core ||= ActiveSupport::Cache::RedisCacheStore.new(url: redis_url('core')).redis
  end

  def self.redis_url(db_name)
    host, port, db = cache_config.values_at(:host, :port, db_name.to_sym)
    "redis://#{host}:#{port}/#{db}"
  end

  def self.cache_config
    CACHE_VALUES[Rails.env.to_sym]
  end
end

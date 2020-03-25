CACHE_VALUES = {
  development: {
    host: 'localhost',
    port: 6379,
    core: 0,
    event: 1,
    content: 2,
    user_sidekiq: 3,
    event_sidekiq: 4,
    reviews: 5,
    organizations: 6
  },
  test: {
    host: 'localhost',
    port: 6379,
    core: 0,
    event: 1,
    content: 2,
    user_sidekiq: 3,
    event_sidekiq: 4,
    reviews: 5,
    organizations: 6
  },
  staging: {
    host: 'stg-redis.i8wvph.ng.0001.euw2.cache.amazonaws.com',
    port: 6379,
    core: 0,
    event: 1,
    content: 2,
    user_sidekiq: 3,
    event_sidekiq: 4,
    reviews: 5,
    organizations: 6
  },
  production: {
    host: 'uk-platform-redis.i8wvph.ng.0001.euw2.cache.amazonaws.com',
    port: 6379,
    core: 0,
    event: 1,
    content: 2,
    user_sidekiq: 3,
    event_sidekiq: 4,
    reviews: 5,
    organizations: 6
  }
}.freeze

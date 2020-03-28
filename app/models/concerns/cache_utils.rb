# frozen_string_literal: true

module CacheUtils
  extend ActiveSupport::Concern

  class_methods do
    def shared_cache(from:)
      @shared_cache ||= Cache.send(from)
    end

    def fetch_from_cache(id)
      @shared_cache.get(id)
    end
  end
end

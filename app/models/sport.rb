# frozen_string_literal: true

class Sport
  include CacheUtils
  shared_cache from: :core

  instance_eval do
    def all
      sports = fetch_from_cache('sports')
      @sports = JSON.parse(sports) if sports
    end

    def find(id)
      all if @sports.blank?
      @sports[id.to_s]
    end

    def where(id: nil, name: nil)
      all if @sports.blank?
      if name.present?
        return @sports.map{|id, rec| rec if name.include?(rec['name'])}.compact
      end
      [id].flatten.map { |i| @sports[i.to_s] }
    end

    def first
      all if @sports.blank?
      @sports.first[0]
    end
  end
end

require "hirameki/config"
require "hirameki/version"

module Hirameki
  extend self

  def configure
    @config = Hirameki::Config.new
    yield(@config)
  end

  def config
    @config
  end

  def get(key)
    val = @config.redis.get(key)
    val.nil? ? val : val.to_i
  end

  def del(key)
    @config.redis.del(key).to_i
  end

  def generate!(value)
    gen_key(value).tap do |key|
      if @config.expiration_time.nil?
        @config.redis.set(key, value)
      else
        @config.redis.setex(key, @config.expiration_time, value)
      end
    end
  end

  private

  def gen_key(value)
    Digest::SHA1.hexdigest("#{@config.pepper}#{Time.now.to_i}#{value}")
  end
end

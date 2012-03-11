require 'spec_helper'

describe Hirameki do
  describe "confgiruration setup" do
    context "full configuration" do
      before(:all) do
        Hirameki.configure do |config|
          config.redis = Redis.new(host: "localhost", port: 6379)
          config.pepper = "tapyokGajivijabroirnajvilphOcyij"
          config.expiration_time = 60 * 10
        end
      end

      subject { Hirameki.config }
      its(:redis) { should be_a(Redis) }
      its(:pepper) { should == "tapyokGajivijabroirnajvilphOcyij" }
      its(:expiration_time) { should == 600 }
    end
  end

  describe "generation of token" do
    module Hirameki
      extend self

      def stub_setex!
        @config.redis.should_not_receive(:setex)
      end

      def stub_set!
        @config.redis.should_not_receive(:set)
      end
    end

    describe "token generation with expiration time" do
      before(:all) do
        Hirameki.configure do |config|
          config.redis = Redis.new(host: "localhost", port: 6379)
          config.pepper = "tapyokGajivijabroirnajvilphOcyij"
        end
        Hirameki.config.redis.flushdb
      end

      it "should not expire any keys" do
        Hirameki.stub_setex!
        key = Hirameki.generate!(1)
        Hirameki.get(key).should == 1
        Hirameki.del(key).should == 1
      end
    end

    describe "token generation without expiration time" do
      before(:all) do
        Hirameki.configure do |config|
          config.redis = Redis.new(host: "localhost", port: 6379)
          config.pepper = "tapyokGajivijabroirnajvilphOcyij"
          config.expiration_time = 1
        end
        Hirameki.config.redis.flushdb
      end

      it "should expire any keys in 1 second" do
        Hirameki.stub_set!
        key = Hirameki.generate!(1)
        sleep(2)
        Hirameki.get(key).should be_nil
        Hirameki.del(key).should == 0
      end
    end

    describe "invalid key" do
      it "should add the given value to redis and return its key" do
        key = Hirameki.generate!(1)
        Hirameki.get(key).should == 1
      end

      it "should return 0 when there is no key in redis" do
        Hirameki.get(10).should be_nil
      end
    end
  end
end

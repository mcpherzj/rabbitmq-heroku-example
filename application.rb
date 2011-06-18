
begin
  # Require the preresolved locked set of gems.
  require ::File.expand_path('../.bundle/environment', __FILE__)
rescue LoadError
  # Fallback on doing the resolve at runtime.
  require "rubygems"
  require "bundler"
  Bundler.setup
end

require 'sinatra/base'
require 'bunny'

require './parse_amqp_url'

class Application < Sinatra::Application
  def initialize *opts
    super *opts

    puts "before amqp settings"
    puts "settings are: " + settings.amqp_url.to_s
    amqp_opts = parse_amqp_url(settings.amqp_url)
    puts "got amqp opts"
    @b = Bunny.new(amqp_opts)
    puts "before start"
    @b.start
    puts "before setting queue name"
    @queue = @b.queue('test1')
    puts "after setting queue name"
  end

  get '/' do
    #'Hello World Stuff'
    'Go to <a href="/publish">/publish</a> or <a href="/receive">/receive</a>.'
  end

  get '/receive' do
    msg = @queue.pop[:payload]
    "received #{msg.inspect}"
  end

  get '/publish' do
    msg = "ping #{Time.new}"
    @queue.publish msg
    "published #{msg.inspect}"
  end
  
end


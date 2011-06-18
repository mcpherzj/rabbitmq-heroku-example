
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
#require 'sinatra'

require './parse_amqp_url'

#require 'rubygems'
#require 'sinatra'

class Application < Sinatra::Application
  def initialize *opts
    super *opts

#    amqp_opts = parse_amqp_url(settings.amqp_url)
#    @b = Bunny.new(amqp_opts)
#    @b.start
#    @queue = @b.queue('test1')
  end

  get '/' do
    #'Hello World Stuff'
    'Go to <a href="/publish">/publish</a> or <a href="/receive">/receive</a>.'
  end

#  get '/receive' do
#    msg = @queue.pop[:payload]
#    "received #{msg.inspect}"
#  end

#  get '/publish' do
#    msg = "ping #{Time.new}"
#    @queue.publish msg
#    "published #{msg.inspect}"
#  end
  
end


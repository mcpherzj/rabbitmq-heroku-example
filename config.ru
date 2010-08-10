require 'application'
require 'sinatra'

set :amqp_url, ENV['RABBITMQ_URL'] || 'amqp://guest:guest@localhost:5672/'
set :env, :prodiction
disable :run

run Application


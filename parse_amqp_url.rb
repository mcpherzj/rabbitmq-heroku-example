# Parse the url-like amqp scheme into a format valid for tmm1/amqp.
def parse_amqp_url(amqp_url)
  uri = URI.parse(amqp_url)
  raise("amqp:// uri required!") unless %w{amqp amqps}.include? uri.scheme
  opts = {}
  opts[:user] = URI.unescape(uri.user) if uri.user
  opts[:pass] = URI.unescape(uri.password) if uri.password
  opts[:vhost] = URI.unescape(uri.path) if uri.path
  opts[:host] = uri.host if uri.host
  opts[:port] = uri.port ? uri.port :
    {"amqp"=>5672, "amqps"=>5671}[uri.scheme]
  opts[:ssl] = uri.scheme == "amqps"
  return opts
end

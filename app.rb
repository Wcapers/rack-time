require_relative 'time_format'

class App

  def call(env)
    env = Rack::Request.new(env)
    if valid_url(env)
      process_request(env.params['format'])
    else
      response(404, "Unknown page :(")
    end
  end

  private

  def process_request(env)
    time = TimeFormat.new(env)
    time.call
    if time.valid?
      response(200, time.result)
    else
      response(400, "Unknown time format #{time.invalid_params}")
    end
  end

  def response(code, message)
    response = Rack::Response.new
    response.status = code
    response['Content-Type'] = 'text/plain'
    response.write message
    response.finish
  end

  def valid_url(env)
    env.fullpath.match(/^.{0,13}/).to_s == '/time?format='
  end
end

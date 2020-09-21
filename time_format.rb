class TimeFormat

  FORMATS = { year: '%Y', month: '%m', day: '%d', hour: ' %H:', minute: '%M', second: '%S' }

  def initialize(params)
    @params = params.split(',')
  end

  def invalid_params
    @invalid_params = @params - FORMATS.keys.map(&:to_s)
  end

  def result
    Time.now.strftime(call) + "\n"
  end

  def call
    invalid_params
    @result = []
    @params.each { |e| @result << FORMATS[e.to_sym] }
    @result.join('-')
  end

  def valid?
    if @invalid_params.empty?
      true
    else
      false
    end
  end
end

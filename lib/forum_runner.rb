#!/usr/bin/env ruby

require 'net/http'
require 'json'

class ForumRunner
  
  METHOD_ARGS = {
    :login => [ :username, :password ],
    :get_thread => [ :threadid, [:page,1], [:per_page,15] ]
  }
  
  attr_accessor :session_key
  
  def initialize(url)
    @session_key = {}
    @uri = URI.parse(url).merge("forumrunner/request.php")
  end

  def do_request(params)
    req = Net::HTTP::Post.new(@uri.path)
    req.set_form_data(params)
    req['cookie'] = @session_key.collect { |*c| c.join('=') }.join('; ')
    res = Net::HTTP.new(@uri.host, @uri.port).start { |http| http.request(req) }
    unless res['set-cookie'].nil?
      res_cookies = res.each_header { }['set-cookie'].collect { |v| v.split(/\s*;\s*/).first }.inject({}) { |h,c| k,v = c.split(/=/,2); h[k] = v; h } #/
      @session_key.merge!(res_cookies) 
    end
    return JSON.parse(res.body)
  end

  def method_missing(sym, *args)
    request_args = { :cmd => sym.to_s }
    if METHOD_ARGS.has_key?(sym) and not args.last.is_a?(Hash)
      METHOD_ARGS[sym].each { |arg|
        default = nil
        if arg.is_a?(Array)
          default = arg[1]
          arg = arg[0]
        end
        value = args.shift
        if value.nil?
          value = default
        end
        request_args[arg] = value
      }
    else
      request_args = args.last.merge(request_args)
    end
    self.do_request(request_args)
  end
end

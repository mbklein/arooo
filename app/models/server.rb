require 'mechanize'
require 'nokogiri'

class Server < ActiveRecord::Base

has_many :games, :dependent => :destroy
#serialize :cookies

def agent
  unless @agent
    @agent = Mechanize.new
  end
  @agent
end

def load_cookies
  StringIO.open(self.cookies.to_s) { |cookies|
    self.agent.cookie_jar.load_cookiestxt(cookies)
  }
end

def save_cookies
  StringIO.open('','w') { |cookies|
    self.agent.cookie_jar.dump_cookiestxt(cookies)
    self.update_attribute :cookies, cookies.string
  }
end

def uri
  unless @uri
    @uri = URI.parse(self.base_url)
  end
  @uri
end

def get(path)
  self.load_cookies
  result = self.agent.get(self.uri.merge(path))
  self.save_cookies
  result
end

def login
  self.get('usercp.php')
  form = self.agent.page.form_with :action => /login.php/
  if form.nil?
    # No login form on User CP; already logged in!
    return true
  else
    form.vb_login_username = self.username
    form.vb_login_password = self.password
    form.checkbox_with(:name => 'cookieuser').check
    form.submit(form.button_with(:value => 'Log in'))
    self.save_cookies
    if self.agent.page.body =~ /redirect you/
      return true
    else
      return false
    end
  end
end

def get_thread(thread_id, page = 1)
  if page < 1
    raise RangeError, "Page must be >= 1"
  end  
  self.get("showthread.php?t=#{thread_id}&page=#{page}")
  (this_page, last_page) = self.agent.page.body.scan(/Page ([0-9]+) of ([0-9]+)/).uniq.flatten.collect { |m| m.to_i }
  if this_page.nil? and last_page.nil?
    this_page = 1
    last_page = 1
  end
  if this_page < page
    raise RangeError, "Page #{page} out of range 1-#{last_page}"
  end
  return { :doc => self.agent.page.parser, :page => this_page, :last_page => last_page }
end

end

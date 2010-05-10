require 'mechanize'
require 'nokogiri'

class Server < ActiveRecord::Base

has_many :games, :dependent => :destroy
serialize :cookies

def agent
  unless @agent
    @agent = Mechanize.new
  end
  @agent
end

def uri
  unless @uri
    @uri = URI.parse(self.base_url)
  end
  @uri
end

def get(path)
  unless self.cookies.nil?
    self.agent.cookie_jar = self.cookies
  end
  self.agent.get(self.uri.merge(path))
  self.update_attribute :cookies, self.agent.cookie_jar
end

def login
  self.get('usercp.php')
  form = self.agent.page.forms.find { |frm| frm.fields.find { |fld| fld.name == 'vb_login_username' } }
  if form.nil?
    # No login form on User CP; already logged in!
    return true
  else
    form.vb_login_username = self.username
    form.vb_login_password = self.password
    form.submit
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
  return { :doc => Nokogiri(self.agent.page.body), :page => this_page, :last_page => last_page }
end

end

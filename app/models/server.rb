class Server < ActiveRecord::Base

has_many :games

def login(username, password)
  self.runner.login(username, password)
end

def session_key
  self.runner.session_key
end

def session_key=(value)
  self.runner.session_key = value
end

def runner
  if @runner.nil?
    @runner = ForumRunner.new(self.base_url)
    if self.session_key
      @runner.session_key = self.session_key
    end
  end
  @runner
end

end

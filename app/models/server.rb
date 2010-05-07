class Server < ActiveRecord::Base

has_many :games

def runner
  if @runner.nil?
    @runner = ForumRunner.new(self.base_url)
    @runner.login(self.username, self.password)
  end
  @runner
end

end

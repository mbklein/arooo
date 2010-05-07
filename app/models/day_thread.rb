require 'forum_runner'

class ThreadLoadError < Exception; end
  
class DayThread < ActiveRecord::Base

belongs_to :day

def server
  self.day.game.server
end

def runner
  self.server.runner
end

def get_page(page = nil)
  if page.nil?
    page = self.last_page
  end
  result = self.runner.get_thread(self.topic_id, page, 50)
  if result['success']
    return result['data']
  else
    raise ThreadLoadError, result['message']
  end
end

def next_page
  self.get_page(self.last_page.to_i + 1)
end

end

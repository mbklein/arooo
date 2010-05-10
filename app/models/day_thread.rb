require 'forum_runner'

class ThreadLoadError < Exception; end
  
class DayThread < ActiveRecord::Base

belongs_to :day

def server
  self.day.game.server
end

def get_page(page = nil)
  if page.nil?
    page = self.last_page || 1
  end
  result = self.server.get_thread(self.topic_id, page)
  self.update_attribute(:last_page,page)
  return result
end

def next_page
  self.get_page(self.last_page.to_i + 1)
end

def each_unread_page
  page = self.get_page
  until page.nil? do
    yield(page)
    if page[:page] < page[:last_page]
      page = self.next_page
    else
      page = nil
    end
  end
end

end

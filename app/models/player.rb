class Player < ActiveRecord::Base
  belongs_to :game
  belongs_to :person

  def method_missing(sym, *args)
    if self.person.respond_to?(sym)
      self.person.send(sym, *args)
    else
      super(sym, *args)
    end
  end
end

class NoAccess
  class << self
    def method_missing(sym, *args)
      return false
    end
  end
end

class Access < ActiveRecord::Base

  belongs_to :game
  belongs_to :user
  
  @@acl = {
    'moderator' => [:moderate,:observe,:view],
    'observer'  => [:observe,:view],
    'player'    => [:view]
  }

  def method_missing(sym, *args)
    if /^can_(.+)\?$/ === sym.to_s
      permissions(self.role).include?($1.to_sym)
    else
      super sym, *args
    end
  end
  
  private
  def permissions(role)
    @@acl[role] || []
  end
  
end

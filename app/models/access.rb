class Access < ActiveRecord::Base

  belongs_to :game
  belongs_to :user
  
  @@acl = {
    'moderator' => [:edit,:observe,:view],
    'observer'  => [:observe,:view],
    'player'    => [:view]
  }

  def method_missing(sym, *args)
    if /^can_(.+)\?$/ === sym.to_s
      permissions(self.role).include?($1)
    else
      super sym, *args
    end
  end
  
  private
  def permissions(role)
    @@acl[role] || []
  end
  
end

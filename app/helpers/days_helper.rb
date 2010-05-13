module DaysHelper

  def colorize(player)
    if player.nil?
      ''
    else
      color = nil;
      if @colorize && can_observe?(player.game)
        if player.alignment =~ /^G/ 
          color = 'green'
        elsif player.alignment =~ /^B/
          color = 'red'
        end
      end
      if color.nil?
        player.name
      else 
        if @bbcode
          %{<span style="color: #{color}">[color="#{color}"]#{player.name}[/color]</span>}
        else
          %{<span style="color: #{color}">#{player.name}</span>}
        end
      end
    end
  end
  
end

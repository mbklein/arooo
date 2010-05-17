module DaysHelper

  DEFAULT_COLORS = {
    'GG' => 'green',
    'GGRP' => 'blue',
    'BG' => 'red',
    'BGRP' => 'purple'
  }

  def colorize(player)
    if player.nil?
      ''
    else
      color = nil;
      if @colorize && can_observe?(player.game)
        color = DEFAULT_COLORS[player.alignment]
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

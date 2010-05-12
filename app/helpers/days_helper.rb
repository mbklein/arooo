module DaysHelper

  def colorize(person)
    if person.nil?
      ''
    else
      color = nil;
      if @colorize
        if person.alignment =~ /^G/ 
          color = 'green'
        elsif person.alignment =~ /^B/
          color = 'red'
        end
      end
      if color.nil?
        person.name
      else 
        if @bbcode
          %{<span style="color: #{color}">[color="#{color}"]#{person.name}[/color]</span>}
        else
          %{<span style="color: #{color}">#{person.name}</span>}
        end
      end
    end
  end
  
end

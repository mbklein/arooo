module DaysHelper

  def colorize(person)
    if person.nil?
      ''
    else
      if @colorize
        color = person.alignment =~ /^G/ ? 'green' : 'red'
        %{<span style="color: #{color}">#{person.name}</span>}
      else
        person.name
      end
    end
  end
  
end

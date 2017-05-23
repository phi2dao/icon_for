require "json"

module IconFor
  class IconSet
    def initialize data
      if data.is_a? File
        @data = JSON.load data
      else
        @data = data
      end
    end

    def [] mime
      if @data["types"].key? mime
        icon = @data["types"][mime]
      else
        mime.match /(\w*)\/.*/
        if @data["types"].key? $1 + '/*'
          icon = @data["types"][$1 + '/*']
        else
          icon = "fallback"
        end
      end
      "#{IconFor.config.prefix}#{@data["icons"][icon]}#{IconFor.config.suffix}"
    end
  end
end
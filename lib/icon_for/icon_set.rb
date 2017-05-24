require "json"

module IconFor
  class IconSet
    def initialize data
      case data
      when Hash then @data = data
      when String then @data = JSON.parse data
      when File then @data = JSON.parse data.read
      end
    end

    def [] mime, prefix: IconFor.config.prefix, suffix: IconFor.config.suffix
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
      "#{prefix}#{@data["icons"][icon]}#{suffix}"
    end
  end
end
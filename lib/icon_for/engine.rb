module IconFor
  def self.register const, data, options = {}
    IconFor.const_set const, IconFor::IconSet.new(data)
    @default = const if options[:default]
  end

  def self.[] mime
    if @default
      IconFor.const_get(@default)[mime]
    end
  end

  def self.default
    @default
  end

  def self.default= const
    @default = const
  end
end
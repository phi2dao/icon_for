module IconFor
  @config = Struct.new(:default, :prefix, :suffix).new(nil, nil, nil)

  def self.register const, data, options = {}
    IconFor.const_set const, IconFor::IconSet.new(data)
    @config.default = const if options[:default]
  end

  def self.[] mime
    if @config.default
      IconFor.const_get(@config.default)[mime]
    end
  end

  def self.config
    @config
  end
end
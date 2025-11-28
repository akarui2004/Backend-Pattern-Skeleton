class DatabaseConnectionSingleton
  @instance = nil

  private_class_method :new

  def self.instance
    @instance ||= new
  end

  def initialize
    @connected = false
  end

  def connect
    @connected = true
  end

  def connected?
    @connected
  end

  def disconnect
    @connected = false
  end
end

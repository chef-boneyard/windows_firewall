actions :open

attribute :port, :kind_of => Integer
attribute :name, :kind_of => String, :name_attribute => true
attribute :direction, :kind_of => Symbol, :default => :in, :equal_to => [:in, :out]
attribute :protocol, :kind_of => Symbol, :default => :TCP, :equal_to => [:TCP]
attribute :firewall_action, :kind_of => Symbol, :default => :allow, :equal_to => [:allow, :deny]
attribute :localip, :kind_of => String, :default => 'any'
attribute :remoteip, :kind_of => String, :default => 'any'

def initialize(*args)
  super
  @action = :open
end

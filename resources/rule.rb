actions :open

attribute :name, :kind_of => String, :name_attribute => true
attribute :direction, :kind_of => Symbol, :default => :in, :equal_to => [:in, :out]
attribute :firewall_action, :kind_of => Symbol, :default => :allow, :equal_to => [:allow, :deny]
attribute :protocol, :kind_of => Symbol, :default => :TCP, :equal_to => [:TCP]
attribute :remoteport, :kind_of => String, :default => 'Any'
attribute :localport, :kind_of => String, :default => 'Any'
attribute :program, :kind_of => String, :default => 'Any'
attribute :remoteip, :kind_of => String, :default => 'Any'
attribute :localip, :kind_of => String, :default => 'Any'

def initialize(*args)
  super
  @action = :open
end

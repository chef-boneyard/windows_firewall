actions :open

attribute :localport, :kind_of => String, :default => :Any
attribute :name, :kind_of => String, :name_attribute => true
attribute :direction, :kind_of => Symbol, :default => :in, :equal_to => [:in, :out]
attribute :protocol, :kind_of => Symbol, :default => :TCP, :equal_to => [:TCP]
attribute :firewall_action, :kind_of => Symbol, :default => :allow, :equal_to => [:allow, :deny]
attribute :remoteport, :kind_of => String, :default => :Any
attribute :program, :kind_of => String, :default => :Any
attribute :remoteaddress, :kind_of => String, :default => :Any




def initialize(*args)
  super
  @action = :open
end
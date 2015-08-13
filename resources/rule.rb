actions :create
default_action :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :description, :kind_of => String, :default => 'Firewall rule'
attribute :localip, :kind_of => String, :default => nil
attribute :localport, :kind_of => String, :default => nil
attribute :remoteip, :kind_of => String, :default => nil
attribute :remoteport, :kind_of => String, :default => nil
attribute :dir, :kind_of => Symbol, :default => :in, :equal_to => [:in, :out]
attribute :protocol, :kind_of => String, :default => 'TCP'
attribute :firewall_action, :kind_of => Symbol, :default => :allow, :equal_to => [:allow, :block, :bypass]
attribute :profile, :kind_of => Symbol, :default => :any, :equal_to => [:public, :private, :domain, :any]
attribute :program, :kind_of => String, :default => nil
attribute :service, :kind_of => String, :default => nil
attribute :interfacetype, :kind_of => Symbol, :default => :any, :equal_to => [:any, :wireless, :lan, :ras]

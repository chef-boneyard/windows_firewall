property :rule_name, String, name_property: true
property :description, String, default: 'Firewall rule'
property :localip, String, default: nil
property :localport, String, default: nil
property :remoteip, String, default: nil
property :remoteport, String, default: nil
property :dir, Symbol, default: :in, equal_to: [:in, :out]
property :protocol, String, default: 'TCP'
property :firewall_action, Symbol, default: :allow, equal_to: [:allow, :block, :bypass]
property :profile, Symbol, default: :any, equal_to: [:public, :private, :domain, :any]
property :program, String, default: nil
property :service, String, default: nil
property :interfacetype, Symbol, default: :any, equal_to: [:any, :wireless, :lan, :ras]

action :create do
  begin
    # netsh advfirewall firewall set rule name="SSH" dir=in action=allow protocol=TCP localport=22
    args = {}

    name = new_resource.rule_name
    desc = new_resource.description
    program = new_resource.program
    args['name'] = "\"#{name}\""
    args['description'] = "\"#{desc}\""
    args['localip'] = new_resource.localip
    args['localport'] = new_resource.localport
    args['remoteip'] = new_resource.remoteip
    args['remoteport'] = new_resource.remoteport
    args['dir'] = new_resource.dir
    args['protocol'] = new_resource.protocol
    args['action'] = new_resource.firewall_action
    args['profile'] = new_resource.profile
    args['program'] = "\"#{program}\""
    args['service'] = new_resource.service
    args['interfacetype'] = new_resource.interfacetype

    # cmdargs = args.map { |k, v| "#{k}=#{v}" }.join(' ')

    current_rule = shell_out("netsh advfirewall firewall show rule name=\"#{name}\"")

    if current_rule.stdout.strip == 'No rules match the specified criteria.'
      # cmd = "netsh advfirewall firewall add rule #{cmdargs}"
      cmd = 'netsh advfirewall firewall add rule '
      args.each do |attribute, value|
        cmd += "#{attribute}=#{value} " unless empty(value)
      end

      Chef::Log.debug("Running firewall command: #{cmd}")

      batch cmd do
        code cmd
      end
    else
      Chef::Log.info("Firewall rule \"#{name}\" already exists.")
    end
  end
end

def empty(value)
  !value || value == '' || value == '""'
end

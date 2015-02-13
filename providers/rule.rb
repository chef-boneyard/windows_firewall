include Chef::Mixin::ShellOut

action :create do
  begin
    # netsh advfirewall firewall set rule name="SSH" dir=in action=allow protocol=TCP localport=22
    args = Hash.new

    name = @new_resource.name
    desc = @new_resource.description
    program = @new_resource.program
    args['name'] = "\"#{name}\""
    args['description'] = "\"#{desc}\""
    args['localip'] = @new_resource.localip
    args['localport'] = @new_resource.localport
    args['remoteip'] = @new_resource.remoteip
    args['remoteport'] = @new_resource.remoteport
    args['dir'] = @new_resource.dir
    args['protocol'] = @new_resource.protocol
    args['action'] = @new_resource.firewall_action
    args['profile'] = @new_resource.profile
    args['program'] = "\"#{program}\""
    args['service'] = @new_resource.service
    args['interfacetype'] = @new_resource.interfacetype

    # cmdargs = args.map { |k, v| "#{k}=#{v}" }.join(' ')

    current_rule = shell_out("netsh advfirewall firewall show rule name=\"#{name}\"")

    if (current_rule.stdout.strip == 'No rules match the specified criteria.')
      # cmd = "netsh advfirewall firewall add rule #{cmdargs}"
      cmd = 'netsh advfirewall firewall add rule '
      args.each do | attribute, value |
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

  new_resource.updated_by_last_action(true)
end

def empty(value)
  !value || value == '' || value == '""'
end
include Chef::Mixin::ShellOut

action :open do
	begin
		#netsh advfirewall firewall set rule name="SSH" dir=in action=allow protocol=TCP localport=22
		args = Hash.new

    name = @new_resource.name
    args['name'] = "\"#{name}\""
		args['dir'] = @new_resource.direction
		args['action'] = @new_resource.firewall_action
		args['protocol'] = @new_resource.protocol
		args['localport'] = @new_resource.port
		
		cmdargs = args.map{|k,v| "#{k}=#{v}"}.join(' ')

    currentRule = shell_out("netsh advfirewall firewall show rule name=\"#{name}\"")

    if(currentRule.stdout.strip() == "No rules match the specified criteria.")
      cmd = "netsh advfirewall firewall add rule #{cmdargs}"

      Chef::Log.debug("Running firewall command: #{cmd}")
      windows_batch cmd do
        code cmd
      end
    else
      Chef::Log.info("Firewall rule \"#{name}\" already exists.")
    end
	end
end
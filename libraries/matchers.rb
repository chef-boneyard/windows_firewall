# Chefspec custom matcher

if defined?(ChefSpec)
  def create_windows_firewall(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:windows_firewall, :create, resource_name)
  end
end


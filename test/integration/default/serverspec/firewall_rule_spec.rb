require 'spec_helper'

describe 'Firewall Rule' do
  describe command('netsh advfirewall firewall show rule name=Apache') do
    its(:stdout) { should match /8080/ }
  end
  describe command('netsh advfirewall firewall show rule name=Apache') do
    its(:stdout) { should match /192.168.1.1/ }
  end
end

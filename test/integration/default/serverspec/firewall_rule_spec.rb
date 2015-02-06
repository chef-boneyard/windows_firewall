require 'spec_helper'

describe 'Firewall Rule' do

  describe command('dir') do
    its(:exit_status) { should eq 0 }
  end

end
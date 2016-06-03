require 'spec_helper'
describe 'ftpserver' do

  context 'with defaults for all parameters' do
    it { should contain_class('ftpserver') }
  end
end

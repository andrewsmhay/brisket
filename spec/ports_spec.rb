require 'spec_helper'


describe Ports do
  it 'initalizes apac ports' do
  	expect(Ports.remote_ports_ary).to eq ['22','23','513','3389','5900']
  end
end
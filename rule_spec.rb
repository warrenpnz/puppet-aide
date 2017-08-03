require 'spec_helper'

describe 'aide::rule', type: 'class' do
  let(:title) { 'MyRule' }
  let(:params) { {:rules => [ 'p', 'sha256'] } }

  it { is_expected.to contain_class('aide::rule') }

  it do
    is_expected.to contain_file('/etc/aide.conf').with({
      'ensure' => 'present',
    })
  end
  it do
    is_expected.to contain_file('/etc/aide.conf') \
      .with_content(/^\s*MyRule = p+sha256$/)
  end

end


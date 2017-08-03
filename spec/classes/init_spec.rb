require 'spec_helper'

describe 'aide', type: 'class' do

  context 'default parameters on RedHat 7' do
    let (:facts) {{
      :osfamily               => 'RedHat',
      :operatingsystemrelease => '7',
    }}
    it {
      should contain_class('aide')
      should contain_package('aide').with({
        'ensure' => 'latest',
        'name'   => 'aide',
      })
     # DB file
     should contain_file('/var/lib/aide/aide.db').with_owner('root')
     should contain_file('/var/lib/aide/aide.db').with_group('root')
     should contain_file('/var/lib/aide/aide.db').with_mode('0600')
    }

    describe 'should allow package to be absent' do
      let(:params) {{ :version => 'absent', :package => ['aide'], }}
      it { should contain_package('aide').with_ensure('absent') }
    end

    describe 'should allow package name to be overridden' do
      let(:params) {{ :version => 'latest', :package => ['notaide'], }}
      it { should contain_package('notaide').with_ensure('latest') }
    end

  end

end



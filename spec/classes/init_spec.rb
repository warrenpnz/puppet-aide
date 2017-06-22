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
     should contain_file('/etc/cron.d/aide').with_owner('root')
     should contain_file('/etc/cron.d/aide').with_group('root')
     should contain_file('/etc/cron.d/aide').with_mode('0644')
     # DB file
     should contain_file('/var/lib/aide/aide.db').with_owner('root')
     should contain_file('/var/lib/aide/aide.db').with_group('root')
     should contain_file('/var/lib/aide/aide.db').with_mode('0600')
    }
  end

  context 'default parameters on Debian 8' do
    let (:facts) {{
      :osfamily          => 'Debian',
      :lsbmajdistrelease => '8',
    }}
    it {
      should contain_class('aide')
      should contain_package('aide').with({
        'ensure' => 'latest',
        'name'   => 'aide',
      })
    }
  end

  describe 'aide::install' do
    let (:facts) {{ :osfamily => 'RedHat', }}
    let(:params) {{ :version => 'latest', :package => ['aide'], }}

    it { should contain_package('aide').with_ensure('latest') }

    describe 'should allow package ensure to be overridden' do
      let(:params) {{ :version => 'absent', :package => ['aide'], }}
      it { should contain_package('aide').with_ensure('absent') }
    end

    describe 'should allow the package name to be overridden' do
      let(:params) {{ :version => 'latest', :package => ['notaide'], }}
      it { should contain_package('notaide').with_ensure('latest') }
    end
  end # aide::install

#  describe 'aide::config' do
#    let (:facts) {{ :osfamily => 'RedHat', }}
#    let(:params) {{ :conf_path => '/etc/aide.conf', }}
#  end

end



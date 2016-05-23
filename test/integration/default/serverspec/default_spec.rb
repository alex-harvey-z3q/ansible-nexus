require 'serverspec'

set :backend, :exec

nexus_version = '2.13.0-01'

['wget', 'createrepo'].each do |pkg|
  describe package(pkg) do
    it { is_expected.to be_installed }
  end
end

describe group('nexus') do
  it { is_expected.to exist }
end

describe user('nexus') do
  it { is_expected.to exist }
  it { is_expected.to belong_to_group 'nexus' }
  it { is_expected.to have_login_shell '/bin/bash' }
end

describe file('/usr/share') do
  it { is_expected.to be_directory }
  it { is_expected.to be_owned_by 'root' }
  it { is_expected.to be_grouped_into 'root' }
end

['/var/nexus', '/var/run/nexus', "/usr/share/nexus-#{nexus_version}-bundle.tar.gz"].each do |dir|
  describe file(dir) do
    it { is_expected.to be_directory }
    it { is_expected.to be_owned_by 'nexus' }
    it { is_expected.to be_grouped_into 'nexus' }
  end
end

describe file('/etc/init.d/nexus') do
  its(:content) { is_expected.to match /RUN_AS_USER="nexus"/ }
end

describe file("/usr/share/nexus-#{nexus_version}/conf/nexus.properties") do
  its(:content) { is_expected.to match /application-host=0.0.0.0/ }
  its(:content) { is_expected.to match /application-port=8082/ }
  its(:content) { is_expected.to match /nexus-work=\/var\/nexus/ }
end

describe service('nexus') do
  it { is_expected.to be_running }
end

# TODO: this requires the net-tools package but how to install during test setup?
#describe port(8082) do
#  it { is_expected.to be_listening.with('tcp') }
#end

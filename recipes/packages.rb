#
# Cookbook:: chef-kubernetes
# Recipe:: packages
#
# Copyright:: 2018, Sven Mollinga, All Rights Reserved.

if node[:platform].include?('ubuntu')
  if node[:platform_version].include?('18.04')
    apt_repository 'kubernetes' do
      uri        'http://apt.kubernetes.io/'
      components ['main']
      distribution 'kubernetes-xenial'
      key ['BA07F4FB', 'https://packages.cloud.google.com/apt/doc/apt-key.gpg']
    end
  end
end

package 'kubectl' do
  action :install
end

service 'kubelet' do
  action :enable
end

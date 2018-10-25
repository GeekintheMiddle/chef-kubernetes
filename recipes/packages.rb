#
# Cookbook:: chef-kubernetes
# Recipe:: packages
#
# Copyright:: 2018, Sven Mollinga, All Rights Reserved.

node.default['auto_install'] = %w(docker-ce kubectl kubelet kubeadm)

if node[:platform].include?('ubuntu')
  if node[:platform_version].include?('18.04')
    apt_repository 'kubernetes' do
      uri        'http://apt.kubernetes.io/'
      components ['main']
      distribution 'kubernetes-xenial'
      key ['BA07F4FB', 'https://packages.cloud.google.com/apt/doc/apt-key.gpg']
    end
    apt_repository 'docker' do
      uri        'https://download.docker.com/linux/ubuntu'
      components ['stable']
      key ['0EBFCD88', 'https://download.docker.com/linux/ubuntu/gpg']
    end
  end
end

node['auto_install'].each do |app|
  package "#{app}" do
    action :install
  end
end

service 'kubelet' do
  action :enable
end

#
# Cookbook:: chef-kubernetes
# Recipe:: configuration
#
# Copyright:: 2018, Sven Mollinga, All Rights Reserved.

# Initialize Kubernetes
execute 'kubeinit' do
  command 'kubeadm init'
  not_if { ::File.directory?('/var/lib/kubelet') }
end

directory '/root/.kube' do
  owner 'root'
  group 'root'
  mode '0700'
  action :create
end

execute 'config' do
  command 'cp -i /etc/kubernetes/admin.conf /root/.kube/config'
  not_if { ::File.exist?('/root/.kube/config') }
end

file '/root/.kube/config' do
  mode '0700'
  owner 'root'
  group 'root'
  only_if { ::File.exist?('/root/.kube/config') }
end

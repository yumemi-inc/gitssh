#
# Cookbook Name:: gitssh
# Provider clone
#

action :create do
    ssh_wrapper_path = @new_resource.name
    ssh_key_path = "#{ssh_wrapper_path}.privatekey"
    keystring = @new_resource.keystring
    keyfile = @new_resource.keyfile
    user = @new_resource.user
    if keyfile and ::File.exists?(keyfile)
        ssh_key_path = keyfile
    else
        file ssh_key_path do
            action :create
            owner user
            mode 0400
            content keystring
        end
    end

    template ssh_wrapper_path do
        cookbook "gitssh"
        source "wrap-ssh4git.sh"
        owner user
        variables( :keypath => ssh_key_path )
        mode 0755
    end
end

action :delete do
    ssh_wrapper_path = @new_resource.name
    ssh_key_path = "#{ssh_wrapper_path}.privatekey"
    [ssh_wrapper_path, ssh_key_path].each do |f|
        file f do
            action :delete
        end
    end
end



action :add do
  bash "Adding to sshd_config" do
    code %{
      if [ $(egrep -c "#{new_resource.string}$" /etc/ssh/sshd_config) = 0 ]; then
        if [[ $(cat /etc/ssh/sshd_config) =~ "#{new_resource.match}" ]]; then
          sed -i "s/#{new_resource.match}.*/#{new_resource.string}/g" /etc/ssh/sshd_config
        else
          echo -en "#{new_resource.string}\n" >> /etc/ssh/sshd_config
        fi
      fi
    }
    notifies :restart, resources(:service => "ssh"), :delayed
  end
end

action :add_multiline do
  bash "Adding to sshd_config" do
    code %{
        if [[ ! $(cat /etc/ssh/sshd_config) =~ "#{new_resource.match}" ]]; then
          echo -en "#{new_resource.string}\n" >> /etc/ssh/sshd_config
        fi
    }
    notifies :restart, resources(:service => "ssh"), :delayed
  end
end

action :remove do
  bash "Removing from sshd_config" do
    code %{
      if [ $(grep -c "#{new_resource.string}" /etc/ssh/sshd_config) != 0 ]; then
        sed -i '/#{new_resource.match}.*/ d' /etc/ssh/sshd_config
      fi
    }
    notifies :restart, resources(:service => "ssh"), :delayed
  end
end
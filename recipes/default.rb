service "ssh"

sshd_config "Port" do
  string "Port #{node[:ssh][:port]}"
end

sshd_config "PermitRootLogin" do
  string "PermitRootLogin #{node[:ssh][:permit_root_login]}"
end

sshd_config "PasswordAuthentication" do
  string "PasswordAuthentication #{node[:ssh][:password_authentication]}"
end

sshd_config "PermitEmptyPasswords" do
  string "PermitEmptyPasswords #{node[:ssh][:permit_empty_passwords]}"
end

sshd_config "ChallengeResponseAuthentication" do
  string "ChallengeResponseAuthentication #{node[:ssh][:challenge_response_authentication]}"
end

sshd_config "UsePAM" do
  string "UsePAM #{node[:ssh][:use_pam]}"
end

sshd_config "UseDNS" do
  string "UseDNS #{node[:ssh][:use_dns]}"
end

sshd_config "AllowGroups" do
  string "AllowGroups #{node[:ssh][:allowed_groups].join(' ')}"
  only_if { node[:ssh][:allowed_groups].any? }
end

sshd_config "AllowUsers" do
  string "AllowUsers #{node[:ssh][:allowed_users].join(' ')}"
  only_if { node[:ssh][:allowed_users].any? }
end

sshd_config "DenyGroups" do
  string "DenyGroups #{node[:ssh][:denied_groups].join(' ')}"
  only_if { node[:ssh][:denied_groups].any? }
end

sshd_config "DenyUsers" do
  string "DenyUsers #{node[:ssh][:denied_users].join(' ')}"
  only_if { node[:ssh][:denied_users].any? }
end

sshd_authorized_keys "root" do
  home "/root"
  ssh_keys node[:ssh][:root_authorized_keys]
end

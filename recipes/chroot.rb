service "ssh"

sshd_config "Subsystem sftp" do
  string "Subsystem sftp internal-sftp"
end

sshd_config "Match group sftp" do
  string "Match group sftp\\n  X11Forwarding no\\n  ChrootDirectory %h\\n  AllowTcpForwarding no\\n  ForceCommand internal-sftp\\n"
  action :add_multiline
end

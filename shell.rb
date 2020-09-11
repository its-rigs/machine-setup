ZSH_PATH='/usr/local/bin/zsh'

dep 'zsh', :username do
  requires 'add to shells'

  met? { shell("sudo su - '#{username}' -c 'echo $SHELL'") == ZSH_PATH }
  meet { sudo("chsh -s '#{ZSH_PATH}' #{username}") }
end

dep 'add to shells' do
  requires 'zsh.bin'

  met? { '/etc/shells'.p.grep(ZSH_PATH) }
  meet { '/etc/shells'.p.append(ZSH_PATH) }
end

dep 'zsh.bin' do
  met? {
    ZSH_PATH.p.exists?
  }
end

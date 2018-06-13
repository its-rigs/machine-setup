def getBrewZshPath()
  '/usr/local/bin/zsh'
end

dep 'zsh', :username do
  requires 'add to shells'

  met? { shell("sudo su - '#{username}' -c 'echo $SHELL'") == getBrewZshPath }
  meet { sudo("chsh -s '#{getBrewZshPath}' #{username}") }
end

dep 'add to shells' do
  requires 'zsh.bin'

  met? { '/etc/shells'.p.grep(getBrewZshPath) }
  meet { '/etc/shells'.p.append(getBrewZshPath) }
end

dep 'zsh.bin' do
  met? {
    getBrewZshPath().p.exists?
  }
end

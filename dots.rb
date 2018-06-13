dep 'dots' do
  requires [
    'gitconfig.dot',
    'gitignore.dot',
    'zshrc.dot',
    'zsh-folder.dot'
  ]
end

dep 'dots-repo' do
  met? {
    '~/.dots'.p.exists?
  }

  meet {
    git "https://github.com/its-rigs/dots.git", :to => '~/.dots'
  }
end

meta 'dot' do
  accepts_value_for :from
  accepts_value_for :to

  template {
    met? {
      "#{to}".p.exists?
    }

    meet {
      shell("ln -s #{from} #{to}")
    }
  }
end

dep 'gitconfig.dot' do
  from '~/.dots/gitconfig'
  to '~/.gitconfig'
end

dep 'gitignore.dot' do
  from '~/.dots/gitignore'
  to '~/.gitignore'
end

dep 'zshrc.dot' do
  from '~/.dots/zsh/zshrc'
  to '~/.zshrc'
end

dep 'zsh-folder.dot' do
  from '~/.dots/zsh/zsh/'
  to '~/.zsh/'
end
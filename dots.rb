dep 'dots' do
  requires 'dot-gitconfig'
  requires 'dot-gitignore'
end

dep 'dots-repo' do
  met? {
    '~/.dots'.p.exists?
  }

  meet {
    git "https://github.com/its-rigs/dots.git", :to => '~/.dots'
  }
end

dep 'dot-gitconfig' do
  requires 'dots-repo'

  met? {
    '~/.gitconfig'.p.exists?
  }

  meet {
    shell 'ln -s ~/.dots/gitconfig ~/.gitconfig'
  }
end

dep 'dot-gitignore' do
  requires 'dots-repo'

  met? {
    '~/.gitignore'.p.exists?
  }

  meet {
    shell 'ln -s ~/.dots/gitignore ~/.gitignore'
  }
end

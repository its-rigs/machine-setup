dep 'dots' do
  requires 'dots-repo'
end

dep 'dots-repo' do
  met? {
    '~/.dots'.p.exists?
  }

  meet {
    git "https://github.com/its-rigs/dots.git", :to => '~/.dots'
  }
end

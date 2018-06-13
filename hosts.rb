dep 'rigs' do
  requires [
    'install all brew apps',
    'install all casks apps',
    'dots'
  ]
end

dep 'rigs-sudo', :username do
  requires [
    'zsh'.with(username),
  ]
end
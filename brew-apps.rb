brew_apps = %w{
  git
  htop
  tig
  tldr
}

brew_apps.each do |app|
  dep "#{app}.bin" do
    installs app
  end
end

# dep 'neovim.bin' do
#   provides 'nvim'
# end

dep 'blackbox.bin' do
  provides 'blackbox_initialize'
end

dep 'zsh.bin' do
  met? {
    shell('brew --prefix zsh').p.exists?
  }
end

dep 'install all brew apps' do
  requires [
    *(brew_apps).map { |a| "#{a}.bin" },
    # 'neovim.bin',
    'blackbox.bin',
    'zsh.bin'
  ]
end

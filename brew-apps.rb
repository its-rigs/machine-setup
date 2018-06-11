brew_apps = %w{
  git
  tldr
  htop
  tig
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

dep 'install all brew apps' do
  requires [
    *(brew_apps).map { |a| "#{a}.bin" },
    # 'neovim.bin',
    'blackbox.bin'
  ]
end

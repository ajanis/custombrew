
require 'formula'
class Spoctunnel < Formula

  homepage "https://github.com/ajanis/homebrew-custombrew/sshuttle-spoc-helper"
  url "https://github.com/ajanis/homebrew-custombrew/sshuttle-spoc-helper/archive/v1.1.1.tar.gz"
  version "1.1.1"
  sha256 "6453616e2592d139023b8c96464ce81383ee3a1faf3c79fb5bc6e694dfff2c52"

  # shasum -a 256 v1.1.tar.gz

  def install
      install_dir = "#{etc}/sshuttle-spoc-helper"
      FileUtils.rm_rf install_dir if install_dir.exist?
      etc.install "sshuttle-spoc-helper"
      bin.install 'spoctunnel_profile_setup.sh'
      etc.install 'spoctunnel'
  end

  def post_install
      system "bash", "spoctunnel_profile_setup.sh"
  end

  def caveats; <<-EOS
      Your shell profile had a couple of lines added to it to make `spoctunnel` available on the command line.
      They will still be there after an uninstall, but are adaptive (nothing happens if spoctunnel is uninstalled)
      EOS
    end

end

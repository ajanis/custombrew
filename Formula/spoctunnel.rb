require 'formula'
class Spoctunnel < Formula
  homepage "https://github.com/ajanis/spoc-sshuttle-helper"
  url "https://github.com/ajanis/spoc-sshuttle-helper/releases/download/v1.0.3/v1.0.3.tar.gz"
  version "1.0.3"
  sha256 "8fc4a53cfc40a45165b98e0e61099d4437c4ee5568f7b0ff5fa59304aba06654"

  depends_on "sshuttle"
  depends_on "ajanis/custombrew/sshpass"

  # shasum -a 256 v1.1.tar.gz

  def install
    # Replace /libexec/ with HOMEBREW_PREFIX in scripts
    inreplace "bin/spoctunnel.sh", "HOMEBREW_ETC", etc/"spoctunnel"
    inreplace "bin/spoctunnel.sh", "spoctunnel_version", version
    # Install scripts"
    (etc/"spoctunnel").install Dir["etc/*.conf"]
    Dir[etc/"spoctunnel/*"].each do |config_file|
      FileUtils.chmod 0644, config_file
    end
    bin.install "bin/spoctunnel.sh" => "spoctunnel"
  end

  test do
    # Example test to verify your tool's installation
    system "#{bin}/spoctunnel", "--version"
  end

def caveats; <<-EOS
• You will need to set your SPOC Active-Directory user.  This can be done by answering script prompt, or by adding the following to your shell profile:
export SPOCUSER=\"{SPOC Active-Directory Username}\"

• You will need to create a custom resolver directory.  Run the following commands:

  sudo mkdir /etc/resolver
  sudo echo 'search spoc.charterlab.com spoc.local nameserver 172.22.73.19' > /etc/resolver/spoc.charterlab.com

  - Run the following command and look for the resolver in the output (toward the end):

    sudo scutil --dns

• When you run the script for the first time, you will be prompted to add your SPOC AD Username to the Mac OS Keychain.
EOS
end

end
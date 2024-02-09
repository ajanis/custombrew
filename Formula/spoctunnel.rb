require 'formula'
class Spoctunnel < Formula
  homepage "https://github.com/ajanis/spoc-sshuttle-helper"
  url "https://github.com/ajanis/spoc-sshuttle-helper/releases/download/v1.0.2/v1.0.2.tar.gz"
  version "1.0.2"
  sha256 "c477cde0ef39ab058dc09b75185ffae4c1cf1dd6a55147780461e89b4818e109"

  depends_on "sshuttle"
  depends_on "ajanis/custombrew/sshpass"

  # shasum -a 256 v1.1.tar.gz

  def install
    # Replace /libexec/ with HOMEBREW_PREFIX in scripts
    inreplace "bin/spoctunnel.sh", "HOMEBREW_PREFIX", HOMEBREW_PREFIX
    inreplace "bin/spoctunnel.sh", "spoctunnel_version", version
    # Install script folder to libexec/"spoctunnel"
    libexec.install Dir["libexec/*"]
    bin.install "bin/spoctunnel.sh"
    # Create an executable for the spoctunnel.sh helper script
    bin.write_exec_script (bin/"spoctunnel.sh"), bin/"spoctunnel"
  end



def caveats; <<-EOS
"
- You will need to set your SPOC Active-Directory user.  This can be done by answering script prompt,
or by adding the following to your shell profile:

  export SPOCUSER=\"{SPOC Active-Directory Username}\"


- You will need to create a custom resolver directory.  Run the following commands:

  sudo mkdir /etc/resolver
  sudo echo 'search spoc.charterlab.com spoc.local nameserver 172.22.73.19' > /etc/resolver/spoc.charterlab.com

  - Run the following command and look for the resolver in the output (toward the end):

    sudo scutil --dns

- When you run the script for the first time, you will be prompted to add your SPOC AD Username to the Mac OS Keychain.
"
EOS
end

end
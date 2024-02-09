require 'formula'
class Spoctunnel < Formula
  homepage "https://github.com/ajanis/sshuttle-spoc-helper"
  url "https://github.com/ajanis/sshuttle-spoc-helper/archive/v1.0.0.tar.gz"
  version "1.0.0"
  sha256 "6a49cf6648a89f83ee10ec369103bd3c939654d4"

  depends_on "sshuttle"
  depends_on "ajanis/custombrew/sshpass"

  # shasum -a 256 v1.1.tar.gz

  def install
    # Set install directory
    install_dir = libexec/"spoctunnel"
    # Remove existing direcrtory if exists
    FileUtils.rm_rf install_dir if install_dir.exist?
    # Install script folder to libexec/"spoctunnel"
    libexec.install "spoctunnel"
    # Replace /libexec/ with HOMEBREW_PREFIX in scripts
    inreplace "spoctunnel/spoctunnel.sh", "/libexec/", HOMEBREW_PREFIX
    inreplace "spoctunnel/spoctunnel.sh", "spoctunnel_version", version
    # Create an executable for the sshuttle-spoc-helper-profile-add.sh helper script
    bin.write_exec_script (libexec/"spoctunnel/spoctunnel.sh"), bin"/spoctunnel"
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
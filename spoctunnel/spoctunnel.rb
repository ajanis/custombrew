require 'formula'
class SshuttleSpocHelper < Formula
  homepage "https://github.com/ajanis/sshuttle-spoc-helper"
  url "https://github.com/ajanis/sshuttle-spoc-helper/archive/v1.1.1.tar.gz"
  version "1.0.0"
  sha256 "6453616e2592d139023b8c96464ce81383ee3a1faf3c79fb5bc6e694dfff2c52"

  # shasum -a 256 v1.1.tar.gz
  version "1.0.0"
  sha256 "6453616e2592d139023b8c96464ce81383ee3a1faf3c79fb5bc6e694dfff2c52"

  # shasum -a 256 v1.1.tar.gz

  def install
    install_dir = "#{libexec}/spoctunnel"
    FileUtils.rm_rf install_dir if install_dir.exist?
    libexec.install Dir["spoctunnel"]

    # Replace /libexec/ with HOMEBREW_PREFIX in scripts
    inreplace "spoctunnel.sh", "/libexec/", HOMEBREW_PREFIX
  inreplace "spoctunnel.sh", "spoctunnel_version", version
    # Create an executable for the sshuttle-spoc-helper-profile-add.sh helper script
    bin.write_exec_script (libexec/"spoctunnel/spoctunnel.sh"), bin/"spoctunnel"
  end
  test do
    assert_match "Spoctunnel version 1.0.0", shell_output("#{bin}/spoctunnel version")
  end


def caveats; <<-EOS
You will need to set your SPOC Active-Directory user.  This can be done by answering script prompt,
or by running or adding the following to your $SHELL profile export SPOCUSER="{SPOC Active-Directory Username}"
EOS
end

end
require 'formula'
class Spoctunnel < Formula
  homepage "https://github.com/ajanis/spoc-sshuttle-helper"
  url "https://github.com/ajanis/spoc-sshuttle-helper/releases/download/v2.0.1/v2.0.1.tar.gz"
  version "2.0.1"
  sha256 "d7cef99672c9046e3dc71b810c7c29edb41057ce125632610dd13b95b71f74eb"

  depends_on "sshuttle"
  depends_on "ajanis/custombrew/sshpass"

  # shasum -a 256 v1.1.tar.gz

  def install
    # Replace /libexec/ with HOMEBREW_PREFIX in scripts
    inreplace "bin/spoctunnel.sh", "HOMEBREW_ETC", etc/"spoctunnel"
    inreplace "bin/spoctunnel.sh", "HOMEBREW_VARLOG", var/"log/spoctunnel"
    inreplace "bin/spoctunnel.sh", "spoctunnel_version", version
    # Install scripts"
    (etc/"spoctunnel").install Dir["etc/*.conf"]
    Dir[etc/"spoctunnel/*"].each do |config_file|
      FileUtils.chmod 0644, config_file
    end
    bin.install "bin/spoctunnel.sh" => "spoctunnel"
  end

  def post_install
    # Create the log directory
    (var/"log/spoctunnel").mkpath

    # Set up log rotation using newsyslog
    (etc/"newsyslog.d").mkpath
    File.open(etc/"newsyslog.d/spoctunnel.conf", "w") do |file|
      file.write <<~EOS
        /usr/local/var/log/spoctunnel/spoctunnel.log #{ENV["USER"]}:admin 774 1 1024 * CZ
      EOS
    end
  end

  test do
    # Example test to verify your tool's installation
    system "#{bin}/spoctunnel", "version"
  end

def caveats; <<-EOS
\033[34m• You will need to set your SPOC Active-Directory user.  This can be done by answering script prompt, or by adding the following to your shell profile:
  \033[33m> export SPOCUSER=\"{SPOC Active-Directory Username}\"

\033[34m• You will need to create a custom resolver directory.  Run the following commands:

  \033[33m> sudo mkdir /etc/resolver
  \033[33m> sudo echo 'search spoc.charterlab.com spoc.local nameserver 172.22.73.19' > /etc/resolver/spoc.charterlab.com

\033[34m- Run the following command and look for the resolver in the output (toward the end):

  \033[33m> sudo scutil --dns

\033[34m• You will need to create a link to the newsyslog rule that was created in order to activate log rotation and management.
 Run the following command:

    \033[33m> sudo ln -s /usr/local/etc/newsyslog.d/spoctunnel.conf /etc/newsyslog.d/

\033[34m• When you run the script for the first time, you will be prompted to add your SPOC AD Username to the Mac OS Keychain.

\033[30m
  EOS
end

end
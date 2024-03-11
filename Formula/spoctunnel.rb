require 'formula'
class Spoctunnel < Formula
  homepage "https://github.com/ajanis/spoc-sshuttle-helper"
  url "https://github.com/ajanis/spoc-sshuttle-helper/releases/download/v3.0.1/v3.0.1.tar.gz"
  version "3.0.1"
  sha256 "dfac50bbbce1f78425ea4a75691e03e1bf192c39747f590da3b37c9de27ed2e7"

  depends_on "sshuttle"
  depends_on "ajanis/custombrew/sshpass"

  # shasum -a 256 v1.1.tar.gz

  def install
    # Replace /libexec/ with HOMEBREW_PREFIX in scripts
    inreplace "bin/spoctunnel.sh", "HOMEBREW_ETC", etc/"spoctunnel"
    inreplace "bin/spoctunnel.sh", "HOMEBREW_VARLOG", var/"log/spoctunnel"
    inreplace "bin/spoctunnel.sh", "spoctunnel_version", version
    inreplace "etc/newsyslog/spoctunnel.conf", "HOMEBREW_VARLOG",  var/"log/spoctunnel"
    inreplace "etc/newsyslog/spoctunnel.conf", "HOMEBREW_LOCALUSER",  ENV["USER"]

    # Install allow/deny files"
    (etc/"spoctunnel").install Dir["etc/spoctunnel/*.conf"]
    Dir[etc/"spoctunnel/*"].each do |config_file|
      FileUtils.chmod 0644, config_file
    end

    # Create newsyslog.d directory and log rotation rule in the homebrew prefix
    (etc/"newsyslog.d").mkpath
    (etc/"newsyslog.d").install "etc/newsyslog/spoctunnel.conf"
    (etc/"newsyslog.d/spoctunnel.conf").chmod 0744

    # Create the custom resolver directory and config file in the homebrew prefix
    (etc/"resolver").mkpath
    (etc/"resolver").install "etc/resolver/spoc.charterlab.com"
    (etc/"resolver/spoc.charterlab.com").chmod 0744

    # Install script and bin alias
    bin.install "bin/spoctunnel.sh" => "spoctunnel"
  end

  def post_install
    # Create the log directory in the homebrew prefix
    (var/"log/spoctunnel").mkpath
    (var/"log/spoctunnel").chmod 0744


  end

  test do
    # Example test to verify your tool's installation
    system "#{bin}/spoctunnel", "version"
  end

def caveats; <<-EOS
\033[34m
1) You will need to set your SPOC Active-Directorfy user.
   This can be done by answering script prompt each time you run the script, or by adding the following to your shell profile (RECOMMENDED):
   \033[33m
   > export SPOCUSER=\"<Your SPOC Active-Directory Username>\"
  \033[34m
2) Create a link to the custom resolver file installed by the Formula:
   \033[33m
   > sudo ln -s $(brew --pre`fix)/etc/resolver /etc/resolver
   \033[34mdfdd
   - Run the following command and look for the resolver in the output (toward the end):
     \033[33m
     > sudo scutil --dns
\033[34m
3) Create a link to the custom newsyslog log rotation rule installed by the Formula:
   \033[33m
   > sudo ln -s $(brew --prefix)/etc/newsyslog.d/spoctunnel.conf /etc/newsyslog.d/spoctunnel.conf
\033[34m
4) When you run the script for the first time, you will be prompted to add your SPOC AD Username to the Mac OS Keychain.
   This password will be retrieved automatically when you run spoctunnel in the future.
\033[30m
EOS
end

end
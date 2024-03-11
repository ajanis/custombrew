require 'formula'
class Spoctunnel < Formula
  homepage "https://github.com/ajanis/spoc-sshuttle-helper"
  url "https://github.com/ajanis/spoc-sshuttle-helper/releases/download/v3.0.2/v3.0.2.tar.gz"
  version "3.0.2"
  sha256 "f18ea25226ed404f7ef67c3c0c9525fa08ad41b32a1d80585dba910a5a87c34a"

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
    # (etc/"newsyslog.d").mkpath
    (etc/"newsyslog.d").install "etc/newsyslog/spoctunnel.conf"

    # Create the custom resolver directory and config file in the homebrew prefix
    # (etc/"resolver").mkpath
    (etc/"resolver").install "etc/resolver/spoc.charterlab.com"

    # Install script and bin alias
    bin.install "bin/spoctunnel.sh" => "spoctunnel"
  end

  def post_install
    # Create the log directory in the homebrew prefix
    (var/"log/spoctunnel").mkpath
    (var/"log/spoctunnel").chmod 0744
    (etc/"newsyslog.d/spoctunnel.conf").chmod 0744
    (etc/"resolver/spoc.charterlab.com").chmod 0744
  end

  test do
    # Example test to verify your tool's installation
    system "#{bin}/spoctunnel", "version"
  end

  def caveats
    # Print postinstall instructions
    system "#{bin}/spoctunnel", "postinstall"
  end

end
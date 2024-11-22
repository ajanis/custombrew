require 'formula'
require 'open3'
class Spoctunnel < Formula
  version "13.0.1"
  homepage "https://github.com/ajanis/spoctunnel"
  url "https://github.com/ajanis/spoctunnel/releases/download/v13.0.1/v13.0.1.tar.gz"
  sha256 "585c57f4c513f3a78eda174408beee79c7a3f7143e5306a858189b85b1114685"

  depends_on "sshuttle"
  depends_on "ajanis/custombrew/sshpass"

  # shasum -a 256 v1.1.tar.gz

  def install
    # Replace /libexec/ with HOMEBREW_PREFIX in scripts
    inreplace "bin/spoctunnel.sh", "SPOCTUNNEL_VERSION", version
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
    # Create the pidfile directory in the homebrew prefix
    (var/"run/spoctunnel").mkpath
    (var/"run/spoctunnel").chmod 0744
    # Create newsyslog directory in homebrew prefix
    (etc/"newsyslog.d/spoctunnel.conf").chmod 0744
    # Create resolver directory in homebrew prefix
    (etc/"resolver/spoc.charterlab.com").chmod 0744
    # Run script with postinstall arg
    test_cmd = Open3.capture3("#{bin}/spoctunnel", "postinstall")
    puts test_cmd
  end

  def test
    # Example test to verify your tool's installation
    system "#{bin}/spoctunnel", "version"
  end
end
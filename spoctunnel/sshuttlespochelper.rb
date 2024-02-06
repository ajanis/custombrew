require 'formula'
class SshuttleSpocHelper < Formula
    homepage "https://github.com/ajanis/sshuttle-spoc-helper"
    url "https://github.com/ajanis/sshuttle-spoc-helper/archive/v1.1.1.tar.gz"
    version "1.1.1"
    sha256 "6453616e2592d139023b8c96464ce81383ee3a1faf3c79fb5bc6e694dfff2c52"

    # shasum -a 256 v1.1.tar.gz
    version "1.1.1"
    sha256 "6453616e2592d139023b8c96464ce81383ee3a1faf3c79fb5bc6e694dfff2c52"

    # shasum -a 256 v1.1.tar.gz

    def install
        install_dir = "#{etc}/spoctunnel"
        FileUtils.rm_rf install_dir if install_dir.exist?

        # Install all scripts into /etc/spoctunnel/
        etc.install Dir["spoctunnel"]
        # Replace /etc/ with HOMEBREW_PREFIX in scripts
        inreplace "spoctunnel-profile-add.sh", "/etc/", HOMEBREW_PREFIX
        inreplace "spoctunnel.zsh", "/etc/", HOMEBREW_PREFIX
        # Create an executable for the sshuttle-spoc-helper-profile-add.sh helper script
        bin.write_exec_script (etc/"sshuttle-spoc-helper/sshuttle-spoc-helper-profile-add.sh")
        bin.write_exec_script libexec/"directory-name/your-script.sh"
  end
  bin.install 'add_switchjdk_to_bash_profile_safely.sh'


        bin.install 'spoctunnel_profile_setup.sh'
        etc.install 'spoctunnel'
        if File.file?("#{etc}/sshuttle-spoc_helper.zsh") then
            system "rm", "#{etc}/sshuttle_spoc_helper.zsh"
        end
        libexec.install Dir["*"]
        bin.write_exec_script (libexec/"myapp.py")
        lib.install Dir["lib/*"]
        bin.install 'add_sshuttle_spoc_helper_to_profile.sh'
        etc.install 'sshuttle_spoc_helper.zsh'
    end

    def post_install
        system "zsh", "add_sshuttle_spoc_helper_to_profile.sh"
    end

    def caveats; <<-EOS
        Your ~/.zshrc has been modified to include the sshuttle-spoc-helper.zsh function.
        The include will still be present in your .zshrc file if you uninstall this formula,
        however the include is conditional (so nothing will happen if the sshuttle-spoc-helper.zsh script is removed)
        EOS
      end

  end
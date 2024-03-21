require 'formula'

class Sshpass < Formula
  version "1.0.6"
  url 'http://sourceforge.net/projects/sshpass/files/sshpass/'version'/sshpass-'version'.tar.gz'
  homepage 'http://sourceforge.net/projects/sshpass'
  sha256 'c6324fcee608b99a58f9870157dfa754837f8c48be3df0f5e2f3accf145dee60'

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end

require 'formula'

class Sshpass < Formula
  version "1.0.6"
  homepage "https://github.com/ajanis/sshpass"
  url "https://github.com/ajanis/sshpass/releases/download/v1.0.6/v1.0.6.tar.gz"
  sha256 "011206b77e07abce0b61f697d91b8bbd1e516ae41a2c0f4e74d2e4ee4a033aca"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    system "sshpass"
  end
end

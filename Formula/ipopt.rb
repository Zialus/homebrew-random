class Ipopt < Formula
  desc "Interior Point OPTimizer"
  homepage "https://projects.coin-or.org/Ipopt"
  url "https://www.coin-or.org/download/source/Ipopt/Ipopt-3.12.10.tgz"
  sha256 "e1a3ad09e41edbfe41948555ece0bdc78757a5ca764b6be5a9a127af2e202d2e"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "wget" => :build

  depends_on "openblas"

  def install
    ENV.deparallelize
    Dir.chdir("ThirdParty/Blas") do
      system "./get.Blas"
    end
    Dir.chdir("ThirdParty/Lapack") do
      system "./get.Lapack"
    end
    Dir.chdir("ThirdParty/Mumps") do
      system "./get.Mumps"
    end
    Dir.chdir("ThirdParty/ASL") do
      system "./get.ASL"
    end
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/ipopt", "-version"
  end
end

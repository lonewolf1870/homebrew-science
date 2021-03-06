class Kollector < Formula
  desc "Targeted de novo gene assembly"
  homepage "https://github.com/bcgsc/kollector"
  url "https://github.com/bcgsc/kollector/archive/V1.0.tar.gz"
  sha256 "76dc3e03398ade0ae39b241943ce7dabcf65c09e3b30180726bfea574c462d15"
  head "https://github.com/bcgsc/kollector.git"
  # tag "bioinformatics"

  bottle do
    root_url "https://archive.org/download/brewsci/bottles-science"
    sha256 cellar: :any_skip_relocation, sierra:       "93ef334ebe8c878898ffea334f662e9905b73327d1f9c77c2fa90c50af0f28c8"
    sha256 cellar: :any_skip_relocation, el_capitan:   "6843361fccee9fb0770f11d636cc457046da0f3173965a1d3d9ccba61e34bf65"
    sha256 cellar: :any_skip_relocation, yosemite:     "6843361fccee9fb0770f11d636cc457046da0f3173965a1d3d9ccba61e34bf65"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "36e4b146a71ef0563d83143e83bea1439d85f88698d841f9e1b376304676c67a"
  end

  depends_on "abyss"
  depends_on "biobloomtools"
  depends_on "bwa"
  depends_on "gmap-gsnap"
  depends_on "samtools"

  def install
    prefix.install Dir["*"]
    bin.install_symlink "kollector.sh" => "kollector"
  end

  test do
    system "#{bin}/kollector", "-h"
  end
end

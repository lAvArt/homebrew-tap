class Prj < Formula
  desc "Fuzzy-pick a git repo and open it in your AI agent, editor or a herdr/tmux tab"
  homepage "https://github.com/lAvArt/prj"
  url "https://github.com/lAvArt/prj/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "dd1cd4d6b747a9288c6ba270bdd68bace9591ea8b69e2ac51ad8801f8b8c32be"
  license "MIT"

  depends_on "fzf"

  def install
    bin.install "prj"
    man1.install "prj.1"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/prj --version")
    (testpath/"code/demo").mkpath
    system "git", "init", "-q", testpath/"code/demo"
    ENV["PRJ_CONFIG"] = testpath/"prj.conf"
    ENV["PRJ_STATE_DIR"] = testpath/"state"
    (testpath/"prj.conf").write "roots = #{testpath}/code\n"
    assert_equal "#{testpath}/code/demo", shell_output("#{bin}/prj -p demo").strip
  end
end

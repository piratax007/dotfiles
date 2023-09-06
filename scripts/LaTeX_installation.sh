#!/usr/bin/env bash

set -e

export DEBIAN_FRONTEND=noninteractive

cat <<END
+----------------------------------------------------------------+
  Will be installed the essential LaTeX packages. This will
  take a few minutes.
+----------------------------------------------------------------+
END

su -c "apt -y install texlive-base texlive-bibtex-extra texlive-binaries texlive-extra-utils texlive-font-utils texlive-fonts-extra texlive-fonts-extra-links texlive-fonts-recommended texlive-formats-extra texlive-lang-english texlive-lang-spanish texlive-latex-base texlive-latex-extra texlive-latex-recommended texlive-luatex texlive-metapost texlive-pictures texlive-plain-generic texlive-pstricks texlive-publishers texlive-science texlive-xetex python3-pygments latexmk latexdiff >> /dev/null"

cat <<END
+----------------------------------------------------------------+
  The LaTeX packages has been installed successfully.
+----------------------------------------------------------------+
END

# https://stackoverflow.com/questions/18178084/pandoc-and-foreign-characters

pandoc ver1.md `
  -o pdf/ver1.pdf `
  --pdf-engine=xelatex `
  -V CJKmainfont="Microsoft JhengHei" `
  -V geometry:margin=0.5in

pdf/ver1.pdf

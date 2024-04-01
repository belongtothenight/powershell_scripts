# Markdown to PDF

This script is used to convert markdown files to PDF with following features:

1. Support for complex markdown tables.
2. Support for non-ASCII characters.
3. Support BibTex references.

## Dependencies

1. PanDoc
2. LaTex (pdflatex, bibtex)
3. GNU Awk

## Usage

1. Check for help message:
    ```pwsh
    man md_gen_pdf2.ps1
    ```
2. Convert:
    ```pwsh
    md_gen_pdf2.ps1 reference.md
    ```
Note: Reference file should be in the same directory and named the same as the markdown file.

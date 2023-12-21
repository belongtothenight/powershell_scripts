# Windows LaTex Auto Compile Script

## Requirement

1. MikTeX: <https://miktex.org/> (v23.10.12)
2. Make: <https://stackoverflow.com/questions/32127524/how-to-install-and-use-make-in-windows> (v4.4.1)
3. [optional] PowerShell7: <https://github.com/PowerShell/PowerShell/releases> (v7.4.0)

## File Description

1. [```auto-compile.ps1```](./auto-compile.ps1): Compilation script which recompiles PDF with MikTeX, feel free to adjust settings at the start of the script.
2. [```Makefile```](./Makefile): Making commands. Should not be edited.
3. [```readme.md```](./readme.md): This file.

## Usage

Prepare your working directory like this. Run ```./auto-compile.ps1```.

```
└── working_directory
    ├── Makefile
    ├── auto-compile.ps1
    ├── report.bib
    └── report.tex
```

## Notice

Whenever weird things happens, look for notice written in ```auto-compile.ps1```.

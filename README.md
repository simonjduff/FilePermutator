# FilePermutator
Permutate variables in a file

# Usage:
Supply an input file  
Execute GenerateFiles.ps1 with parameters:  
- -inputfile &lt;name of inputfile&gt;  
- -replacements &lt;replacement tokens&gt;  

## Replacement Tokens
Semi colon separated pairs of replacement tokens, with comma separated sub-values;  
Eg:  
Token1=Value1,Value2;Token2=Value3,Value4

# Usage for non-technical people
## Powershell
Powershell is a scripting console built into modern Windows PCs.  
You can open powershell by pressting the Start button, then typing "powershell".

## Executing scripts
The Powershell environment is like a normal DOS prompt in many ways. The usual commands work.  
CD into the directory that contains the GenerateFiles.ps1 file.  
then type:  
./GenerateFiles.ps1 -templateFile &lt;name of template file&gt; -replacements &lt;token definitions&gt;

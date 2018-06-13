Param(
  [string]$templateFile,
  [string[]] $replacements
)

$replacementTokens = $replacements.Split(';');

$dictionary = @{};
$keys = @();

# Parse the tokens and store them in a dictionary
foreach ($r in $replacementTokens)
{
    $nameSplit = $r.Split('=');
    $name = $nameSplit[0];
    $keys += $name;
    $dictionary[$name] = @();

    foreach ($v in $nameSplit[1].Split(','))
    {
        $dictionary[$name] += $v
    }
}

# foreach ($key in $dictionary.Keys){
#     foreach ($v in $dictionary[$key]){
#         Write-Host "$key $v";
#     }
# }

$fileCount = 0;
function WriteFile($data){
    Write-Host Writing $fileCount
    $newFilename = "$templateFile-out-$fileCount"
    $script:fileCount = $fileCount + 1;
    $template = Get-Content $templateFile

    foreach ($tuple in $data){
        $template = $template.Replace($tuple.Item1, $tuple.Item2)
    }

    Set-Content -Path $newFilename -Value $template
}

function Permutate([int]$tokenIndex, [int[]] $replacementIndexes){
    $key = $keys[$tokenIndex];
    if ($tokenIndex -eq $keys.length) {
        # do output here
        $replacements = @();
        For ($finalKeyIndex = 0;$finalKeyIndex -lt $replacementIndexes.length;$finalKeyIndex++){
            $finalKey = $keys[$finalKeyIndex];
            $finalValue = $dictionary[$finalKey][$replacementIndexes[$finalKeyIndex]]
            $replacements += [System.Tuple]::Create($finalKey,$finalValue)
        }

        WriteFile($replacements)
        return;
    }

    For ($i=0;$i -lt $dictionary[$key].length;$i++){
        Permutate -tokenIndex ($tokenIndex + 1) -replacementIndexes ($replacementIndexes + $i)
    }
}

Permutate -tokenIndex 0 -replacementIndexes @()
$delim = '?'
$includeFiles = '*.txt'
$path = 'C:\temp'
$date = Get-Date -Format yyyyMMddHHmm
(Get-ChildItem $path\* -Include $includeFiles).FullName |
    ForEach-Object {
        $content = Get-Content $_ -Raw
        $trimed = $content.TrimEnd("`r`n")
        if (!($trimed.EndsWith($delim))) {
            $trimed + "`r`n$delim" |
                Out-File $_ -Force
            "Updated $_" | 
                Out-File "$path\output-$date.log" -Append
        }
        else {
            "Skipped $_" | 
                Out-File "$path\output-$date.log" -Append
        }
    }

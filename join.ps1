function join($path)
{
    $files = Get-ChildItem -Path "$path.*.part" | Sort-Object -Property @{Expression={
        $shortName = [System.IO.Path]::GetFileNameWithoutExtension($_.Name)
        $extension = [System.IO.Path]::GetExtension($shortName)
        if ($extension -ne $null -and $extension -ne '')
        {
            $extension = $extension.Substring(1)
        }
        [System.Convert]::ToInt32($extension)
    }}
    $writer = [System.IO.File]::OpenWrite($path)
    foreach ($file in $files)
    {
        $bytes = [System.IO.File]::ReadAllBytes($file)
        $writer.Write($bytes, 0, $bytes.Length)
    }
    $writer.Close()
}

join "InstallTinyTexAndPackages.zip"

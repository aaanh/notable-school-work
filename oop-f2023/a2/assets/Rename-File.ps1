Get-ChildItem *.csv.txt | ForEach-Object {
  $newName = $_.Name -replace '\.txt$', ''
  Rename-Item $_.FullName $newName
}
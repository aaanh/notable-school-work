Get-ChildItem *.csv.csv | ForEach-Object {
  $newName = $_.Name -replace '\.\.txt$', ''
  Rename-Item $_.FullName $newName
}
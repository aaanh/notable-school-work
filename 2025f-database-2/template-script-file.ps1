param (
  [Parameter(Mandatory=$true)][string]$order_number,
  [Parameter(Mandatory=$true)][string]$script_name
)

Write-Output "Creating new file: $order_number-$script_name.sql"

Copy-Item template.sql "$order_number-$script_name.sql"
cd "select-the-folder-where-the-solution-is"
 
$solutionName = "solution-name.sln"

# Get-All-Projects-in-a-solution
$projects = dotnet sln $solutionName list

# Remove-All-Projects
if ($projects.Count -gt 0) {
    foreach ($csproj in $projects) {
        dotnet sln $solutionName remove $csproj
    }
}
 
# Get-All-Csproj-presents-in-a-subfolders
$csprojFiles = Get-ChildItem -Recurse -Filter *.csproj # | Select-Object -First 10
 
foreach ($csprojFile in $csprojFiles) {
    # Create-as-you-want-a-solutionFolder
    $solutionFolderName = $csprojFile.Name.Replace(".csproj", "") #.Replace("...", "")
    
    # Add csproj to the Solution
    $dotNetAdd = dotnet sln $solutionName add -s $solutionFolderName $csprojFile.FullName
}
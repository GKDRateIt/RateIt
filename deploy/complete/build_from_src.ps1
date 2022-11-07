$Self = Split-Path -Parent $MyInvocation.MyCommand.Source
# Write-Output $Self
$Workspace = $(Get-Item $Self).Parent.Parent.FullName

Push-Location $Workspace\front-end
npm ci --cache .npm
if ($?){
    npm run build
}
Pop-Location

# Push-Location $Workspace\back-end

# ./gradlew.bat wrapper

# if ($?){
#     ./gradlew.bat shadowJar
# }

# Pop-Location

# Copy-Item $Workspace\\back-end\\build\\libs\\*-shadow.jar $Self\\app

# $JarName = (Get-ChildItem -Path $Self\app\* -Include "*.jar")[0].Name
# # Write-Output $JarName

# $ComposeYml = (Get-Content $Self/docker-compose.template).
# replace("__WEB_SRC", "$Self\\app"). 
# replace("__JAR_NAME", "$JarName").
# replace( "__DB_INIT", "$Self\\db-init")
# # Write-Output $ComposeYml
# $TmpFile = New-TemporaryFile
# # Write-Output $TmpFile
# $ComposeYml | Out-File  $TmpFile.FullName
# docker.exe compose --file $TmpFile.FullName up
# docker.exe compose --file $TmpFile.FullName rm -fsv
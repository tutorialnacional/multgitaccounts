# Open ps as local user, if isn't administrador then run: runas /user:domain\administrator $^
#
# Check the current startup type of the ssh-agent service
$serviceName = "ssh-agent"
$service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue

if ($null -eq $service) {
    Write-Output "The ssh-agent service is not available on this system."
    exit 1
}

# Set the startup type to Automatic if it is not
if ($service.StartType -ne "Automatic") {
    Write-Output "Setting the ssh-agent service startup type to Automatic."
    Set-Service -Name $serviceName -StartupType Automatic
} else {
    Write-Output "The ssh-agent service is already set to Automatic."
}

# Start the service if it is not running
if ($service.Status -ne "Running") {
    Write-Output "Starting the ssh-agent service."
    Start-Service -Name $serviceName
} else {
    Write-Output "The ssh-agent service is already running."
}

# *** Create a .ssh folder in user folder if not exist ***
# Get the current user's home directory
$userHome = [Environment]::GetFolderPath("UserProfile")

# Define the path for the .ssh folder
$sshFolder = Join-Path -Path $userHome -ChildPath ".ssh"

# Check if the .ssh folder exists
if (-Not (Test-Path -Path $sshFolder)) {
    Write-Output "The .ssh folder does not exist. Creating it now..."
    New-Item -Path $sshFolder -ItemType Directory -Force
    Write-Output "The .ssh folder has been created at: $sshFolder"
} else {
    Write-Output "The .ssh folder already exists at: $sshFolder"
}
# *** END create .ssh folder

# Generate ssh key pass -t type of key | ed25519 pk algoritm | C custom key comment
### suggested file name: id_ed25519_gh_username where gh - github
$userName = "myusername"
Invoke-Expression "ssh-keygen -t ed25519 -C `"$($userName)`" -f id_ed25519_gh_$($userName)"

# *** Get all files in the current directory that start with _id
$currentDirectory = Get-Location
$filesToMove = Get-ChildItem -Path $currentDirectory -Filter "id_*"

# Move each file to the .ssh folder
if ($filesToMove.Count -eq 0) {
    Write-Output "No ssh files 'id_' found in the current directory."
} else {
    foreach ($file in $filesToMove) {
        $destination = Join-Path -Path $sshFolder -ChildPath $file.Name
        Move-Item -Path $file.FullName -Destination $destination -Force
        Write-Output "Moved: $($file.Name) to $sshFolder"
    }
}

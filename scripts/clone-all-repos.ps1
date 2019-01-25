mkdir C:\development
set-location C:\development
$repos = (invoke-webrequest -uri "https://api.github.com/users/thenickfish/repos?page=1&per_page=100" -UseBasicParsing).Content | convertfrom-json
foreach ($repo in $repos){
    git clone $repo.clone_url
}
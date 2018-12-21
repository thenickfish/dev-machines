$bashScript=@'
PAGE=1
curl "https://api.github.com/users/thenickfish/repos?page=$PAGE&per_page=100" |
  grep -e 'git_url*' |
  cut -d \" -f 4 |
  xargs -L1 git clone --depth=1
'@

mkdir C:\development
Set-Location C:\development
$bashScript | Out-File -Encoding ASCII -FilePath git-clone.sh
cmd /c 'C:\Program Files\Git\bin\sh.exe' git-clone.sh

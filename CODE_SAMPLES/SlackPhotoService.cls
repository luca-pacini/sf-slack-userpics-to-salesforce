cd 'C:\Users\lucapacini\sf-Local-Portfolio\sf-slack-userpics-to-salesforce'

# Ensure the file is writable (remove Read-only if set)
attrib -R .\CODE_SAMPLES\SlackPhotoService.cls 2>$null

# Overwrite the file with whatever is on your clipboard
Get-Clipboard | Set-Content .\CODE_SAMPLES\SlackPhotoService.cls -Encoding UTF8

# Commit and push
git add .\CODE_SAMPLES\SlackPhotoService.cls
git commit -m "Code sample: SlackPhotoService (redacted)"
git push origin main


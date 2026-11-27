This is a collection of post-processing scripts to transform r/FreeGameFindings [Bluesky](https://bsky.app/profile/freegamefindings.bsky.social) RSS feed for better readability. It would try to extract the game from the original RSS feed and use it as title. Optionally it would replace Bluesky link with Reddit link.

The scripts are developed for RSS Guard, but feed readers with similar functionality might also work.

## Usage

Paste the following command into RSS Guard post-processing command (Right click on feed > Edit selected items > Post-processing script)

Windows:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((Invoke-WebRequest 'https://raw.githubusercontent.com/CarrieForle/fgf-bsky-post-processing/refs/heads/main/post-processing.ps1' -UseBasicParsing).Content))"
```

Mac/Linux (require Python3):

```bash
python3 -c "$(curl -fsL https://raw.githubusercontent.com/CarrieForle/fgf-bsky-post-processing/refs/heads/main/post-processing.py)"
```

To replace Bluesky link with Reddit link, use these:

Windows:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& ([scriptblock]::Create((Invoke-WebRequest 'https://raw.githubusercontent.com/CarrieForle/fgf-bsky-post-processing/refs/heads/main/post-processing.ps1' -UseBasicParsing).Content)) -UseRedditUrl"
```

Mac/Linux (require Python3):

```bash
python3 -c "$(curl -fsL https://raw.githubusercontent.com/CarrieForle/fgf-bsky-post-processing/refs/heads/main/post-processing.py)" --use-reddit-url
```

The script will update automatically. If you don't want auto update, swap the URL in the command to the following:

Windows: https://raw.githubusercontent.com/CarrieForle/fgf-bsky-post-processing/d5fd85911401d30e0ac93b48254088d154ef6099/post-processing.ps1

Mac/Linux: https://raw.githubusercontent.com/CarrieForle/fgf-bsky-post-processing/d5fd85911401d30e0ac93b48254088d154ef6099/post-processing.py

param(
    [switch]$UseRedditUrl = $false
)

[xml]$rss = [Console]::In.ReadToEnd().Trim()

foreach ($item in $rss.rss.channel.item) {
    $body = [System.Net.WebUtility]::HtmlDecode($item.description)

    if ($UseRedditUrl -and $body -match '(?:https://)?redd\.it/\w+') {
        $item.link = $Matches[0]
    }

    $title = ($body -split ' is free! See the /r/FreeGameFindings thread below', 2)[0]
    $title = ($title -split "\n", 2)[0]
    $title = [System.Net.WebUtility]::HtmlEncode($title).Trim()
    $elem = $item["title"]

    if ($elem) {
        $elem.RemoveAll()
    } else {
        $elem = $rss.CreateElement("title")
        [void]$item.PrependChild($elem)
    }

    $elem.InnerText = $title
}

$settings = New-Object System.Xml.XmlWriterSettings
$settings.Indent = $true
$settings.Encoding = New-Object System.Text.UTF8Encoding($false)
$settings.OmitXmlDeclaration = $false

$writer = [System.Xml.XmlWriter]::Create([Console]::Out, $settings)
$rss.Save($writer)
$writer.Flush()
$writer.Close()

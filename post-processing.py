import argparse
import html
import re
import sys
from xml.etree import ElementTree

parser = argparse.ArgumentParser()
parser.add_argument(
    "--use-reddit-url",
    action="store_true",
    help="Replace Bluesky link with Reddit URL"
)
args = parser.parse_args()

rss_data = sys.stdin.read().strip().encode("utf-8", "ignore").decode()
root = ElementTree.fromstring(rss_data)

for item in root.findall(r"./channel/item"):
    body = html.unescape(item.find("description").text)

    if args.use_reddit_url:
        match = re.search(r"(?:https://)?redd\.it/\w+", body)

        if match:
            link = item.find("link")
            print(link)

            if link is None:
                link = ElementTree.SubElement(item, "link")

            link.text = match[0]

    title = body.split(r" is free! See the /r/FreeGameFindings thread below", 1)[0]
    title = title.split("\n", 1)[0].strip()
    elem = item.find("title")

    if elem is None:
        elem = ElementTree.SubElement(item, "title")

    elem.text = title

output = ElementTree.tostring(root, encoding="unicode", xml_declaration=False)

print('<?xml version="1.0" encoding="utf-8"?>')
print(output)

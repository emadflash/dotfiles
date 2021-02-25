#!/usr/bin/env python3
"""
sets wallpaper from xkcd, existential comics
"""

import pathlib
import random
import subprocess
import time
import urllib.parse

import requests
from bs4 import BeautifulSoup

GAP = 25
SLEEP_REQUEST = 60
TEMP_PATH = "/tmp"
TEMP_FILE = "xkcdbg.png"

# Dict[name:random_url]
# store comic urls here !!!
CONFIG = {
    "xkcd": "https://c.xkcd.com/random/comic",
    "ext": "https://existentialcomics.com/comic/random",
}


def joinUrl(parent_url, url):
    return urllib.parse.urljoin(parent_url, url)


# download comic xkcd
def download_xkcd(url):
    result = requests.get(url)
    soup = BeautifulSoup(result.text, "html.parser")
    div = soup.find("div", id="comic")
    _img_url = div.img["src"]
    img_url = joinUrl(CONFIG["xkcd"], _img_url)
    result = requests.get(img_url)
    return result.content


# only title with 1-comic strip
def download_ext(url):
    result = requests.get(url)
    soup = BeautifulSoup(result.text, "html.parser")
    imgs = soup.findAll("img", class_="comicImg")
    while len(imgs) != 1:
        # loop until you find 1 page comic title
        time.sleep(60)  # stop hammer the server!
        result = requests.get(url)
        soup = BeautifulSoup(result.text, "html.parser")
        imgs = soup.findAll("img", class_="comicImg")
    _img_url = imgs[0]["src"]
    img_url = joinUrl(CONFIG["ext"], _img_url)
    result = requests.get(img_url)
    return result.content


downloaders = {
    "xkcd": download_xkcd,
    "ext": download_ext,
}


# save image to /tmp
def save_image(img):
    p = pathlib.Path(TEMP_PATH) / TEMP_FILE
    return True if p.write_bytes(img) else False


# content from random urls
# from CONFIG dict
def get_random_content():
    waah = random.choice(list(CONFIG.keys()))
    return downloaders[waah](CONFIG.get(waah))


# set background using xwallpaper
def set_bg():
    content = get_random_content()
    if save_image(content):
        print("[*] saved image")
        subprocess.call(["xwallpaper", "--center", TEMP_FILE], cwd=f"/{TEMP_PATH}/")
    else:
        print("[*] error: changing background")


if __name__ == "__main__":
    while True:
        try:
            set_bg()
        except Exception as e:
            print(e.__doc__)
            continue
        time.sleep(GAP * 60)

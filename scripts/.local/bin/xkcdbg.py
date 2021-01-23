#!/usr/bin/env python3
"""
sets wallpaper from xkcd, existential comics
"""

import pathlib
import random
import subprocess
import time

import requests
from bs4 import BeautifulSoup

GAP = 25
TEMP_PATH = "/tmp"
TEMP_FILE = "tmp-xkcdbg.png"

# Dict[name:random_url]
# store comic urls here !!!
CONFIG = {
    "xkcd": "https://c.xkcd.com/random/comic",
    "ext": "https://existentialcomics.com/comic/random",
}

# download comic xkcd
def download_xkcd(url):
    result = requests.get(url)
    soup = BeautifulSoup(result.text, "html.parser")
    div = soup.find("div", id="comic")
    img_url = div.img["src"]
    result = requests.get("https:" + img_url)
    img = result.content
    return img


# download comic existential
# only title with 1-comic strip
def download_ext(url):
    result = requests.get(url)
    soup = BeautifulSoup(result.text, "html.parser")
    imgs = soup.findAll("img", class_="comicImg")
    while len(imgs) != 1:
        # loop until you find 1 page comic title
        result = requests.get(url)
        soup = BeautifulSoup(result.text, "html.parser")
        imgs = soup.findAll("img", class_="comicImg")
    img_url = imgs[0]["src"]
    result = requests.get("https:" + img_url)
    img = result.content
    return img


# save image to /tmp
def save_image(img):
    p = pathlib.Path(f"/{TEMP_PATH}/{TEMP_FILE}")
    return True if p.write_bytes(img) else False


# content from random urls
# from CONFIG dict
def get_random_content():
    waah = random.choice(list(CONFIG.keys()))
    # TODO rnd_content = lambda key: download_{key}(CONFIG.get(key))
    # TODO return rnd_content(waah)
    if waah == "ext":
        return download_ext(CONFIG.get(waah))
    elif waah == "xkcd":
        return download_xkcd(CONFIG.get(waah))


# set background
# using xwallpaper
def set_bg():
    content = get_random_content()
    if save_image(content):
        subprocess.call(["xwallpaper", "--center", TEMP_FILE], cwd=f"/{TEMP_PATH}/")

    else:
        print("ERROR: changing background...")


# run inside while loop
def run():
    while True:
        try:
            set_bg()
        except Exception as e:
            print(e.__doc__)
            continue
        time.sleep(GAP * 60)


if __name__ == "__main__":
    run()

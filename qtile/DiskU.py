# -*- coding: utf-8 -*-
# Copyright (c) 2020 Yashdeep Singh
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
import psutil

from libqtile.widget import base

__all__ = ["DiskU"]


class DiskU(base.ThreadedPollText):
    """Displays memory/swap usage

    DiskUsed: Returns Used Disk space
    DiskTotal: Returns total Disk Space
    DiskFree: Returns amount of memory free
    DiskPercent: Returns Disk percentage

    Widget requirements: psutil_.

    .. _psutil: https://pypi.org/project/psutil/
    """

    orientations = base.ORIENTATION_HORIZONTAL
    defaults = [
        ("format", "{DiskUsed}/{DiskTotal}", "Formatting for field names."),
        ("update_interval", 60.0, "Update interval"),
        ("path", "/", "Partition mount point"),
        ("space_type", "used", "used/total"),
    ]

    def __init__(self, **config):
        super().__init__(**config)
        self.add_defaults(DiskU.defaults)

    def tick(self):
        self.update(self.poll())
        return self.update_interval

    def poll(self):
        hdd = psutil.disk_usage(self.path)
        val = {}
        val["DiskTotal"] = hdd.total / (2**30)
        val["DiskUsed"] = hdd.used / (2**30)
        val["DiskFree"] = hdd.free / (2**30)
        if self.space_type == 'used':
            val["DiskPercent"] = str(round((val['DiskUsed'] / val['DiskTotal']) * 100)) + "%"
        elif self.space_type == 'free':
            val["DiskPercent"] = str(round((val['DiskFree'] / val['DiskTotal']) * 100)) + "%"
        return self.format.format(**val)

#!/usr/bin/env python
from lxml import etree
import sys

tree = etree.parse(sys.argv[1])
print tree.xpath('string(/domain/name/text())')

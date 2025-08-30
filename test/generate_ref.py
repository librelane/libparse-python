import json
from pathlib import Path
from typing import Dict
from libparse import LibertyParser, LibertyAst

__file_dir__ = Path(__file__).absolute().parent

files = __file_dir__.glob("*.lib")
for file in sorted(files):
    print(file)
    x = open(file, "r")
    try:
        parsed = LibertyParser(x)
        with open(str(file) + ".ref", "w", encoding="utf8") as f:
            json.dump(parsed.ast.to_dict(), fp=f)
    except RuntimeError as e:
        pass

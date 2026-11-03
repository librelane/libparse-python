from pathlib import Path

import pytest


def pytest_configure():
    pytest.test_root = Path(__file__).absolute().parent
    pytest.parsing_tests = pytest.test_root.glob("*.lib")

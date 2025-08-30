import pytest
from pathlib import Path

def pytest_configure():
    pytest.test_root = Path(__file__).absolute().parent
    pytest.parsing_tests = pytest.test_root.glob("*.lib")

import pytest
from pathlib import Path

def pytest_configure():
    pytest.test_root = Path(__file__).absolute().parent
    pytest.parsing_tests = sorted(pytest.test_root.glob("*.lib"))

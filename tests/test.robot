*** Settings ***
Library		      Selenium2Library


*** Test Cases ***
Test a Syntax Highlight for ".robot" extension
    Open Browser    http://localhost:8000/    browser=${browser}

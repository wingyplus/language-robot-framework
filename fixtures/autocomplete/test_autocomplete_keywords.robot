*** Variables ***
${VARIABLE1}    value
${VARIABLE2}    value

*** Keywords ***
Run Program
    [Arguments]    @{args}
    Run Process    program.py    @{args}    # Named arguments are not recognized from inside @{args}
With documentation
    [Documentation]    documentation
Without documentation
With arguments
    [Arguments]    ${arg1}    @{arg2}    &{arg3}
Without arguments
With default value arguments
    [Arguments]    ${arg1}=default value ${VARIABLE1}    ${arg2}    @{arg3}    &{arg4}    ${arg5}=default value    @{arg6}=${VARIABLE1} and ${VARIABLE2}
With ${embedded} arguments
Test keyword
    

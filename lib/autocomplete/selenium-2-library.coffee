# coffeelint: disable=max_line_length
module.exports = [
  {
    text: 'Add Cookie'
    snippet: 'Add Cookie  ${1:name}  ${2:value}  ${3:path=None}  ${4:domain=None}  ${5:secure=None}  ${6:expiry=None}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Alert Should Be Present'
    snippet: 'Alert Should Be Present  ${1:text=}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Assign Id To Element'
    snippet: 'Assign Id To Element  ${1:locator}  ${2:id}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Capture Page Screenshot'
    snippet: 'Capture Page Screenshot  ${1:filename=None}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Checkbox Should Be Selected'
    snippet: 'Checkbox Should Be Selected  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Checkbox Should Not Be Selected'
    snippet: 'Checkbox Should Not Be Selected  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Choose Cancel On Next Confirmation'
    snippet: 'Choose Cancel On Next Confirmation'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Choose File'
    snippet: 'Choose File  ${1:locator}  ${2:file_path}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Choose Ok On Next Confirmation'
    snippet: 'Choose Ok On Next Confirmation'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Clear Element Text'
    snippet: 'Clear Element Text  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Click Button'
    snippet: 'Click Button  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Click Element'
    snippet: 'Click Element  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Click Element At Coordinates'
    snippet: 'Click Element At Coordinates  ${1:locator}  ${2:xoffset}  ${3:yoffset}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Click Image'
    snippet: 'Click Image  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Click Link'
    snippet: 'Click Link  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Close All Browsers'
    snippet: 'Close All Browsers'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Close Browser'
    snippet: 'Close Browser'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Close Window'
    snippet: 'Close Window'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Confirm Action'
    snippet: 'Confirm Action'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Create Webdriver'
    snippet: 'Create Webdriver  ${1:driver_name}  ${2:alias=None}  ${3:kwargs={}}  ${4:**init_kwargs}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Current Frame Contains'
    snippet: 'Current Frame Contains  ${1:text}  ${2:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Current Frame Should Not Contain'
    snippet: 'Current Frame Should Not Contain  ${1:text}  ${2:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Delete All Cookies'
    snippet: 'Delete All Cookies'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Delete Cookie'
    snippet: 'Delete Cookie  ${1:name}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Double Click Element'
    snippet: 'Double Click Element  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Drag And Drop'
    snippet: 'Drag And Drop  ${1:source}  ${2:target}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Drag And Drop By Offset'
    snippet: 'Drag And Drop By Offset  ${1:source}  ${2:xoffset}  ${3:yoffset}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Element Should Be Disabled'
    snippet: 'Element Should Be Disabled  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Element Should Be Enabled'
    snippet: 'Element Should Be Enabled  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Element Should Be Visible'
    snippet: 'Element Should Be Visible  ${1:locator}  ${2:message=}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Element Should Contain'
    snippet: 'Element Should Contain  ${1:locator}  ${2:expected}  ${3:message=}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Element Should Not Be Visible'
    snippet: 'Element Should Not Be Visible  ${1:locator}  ${2:message=}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Element Text Should Be'
    snippet: 'Element Text Should Be  ${1:locator}  ${2:expected}  ${3:message=}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Execute Async Javascript'
    snippet: 'Execute Async Javascript  ${1:*code}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Execute Javascript'
    snippet: 'Execute Javascript  ${1:*code}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Focus'
    snippet: 'Focus  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Frame Should Contain'
    snippet: 'Frame Should Contain  ${1:locator}  ${2:text}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Alert Message'
    snippet: 'Get Alert Message'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get All Links'
    snippet: 'Get All Links'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Cookie Value'
    snippet: 'Get Cookie Value  ${1:name}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Cookies'
    snippet: 'Get Cookies'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Element Attribute'
    snippet: 'Get Element Attribute  ${1:attribute_locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Horizontal Position'
    snippet: 'Get Horizontal Position  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get List Items'
    snippet: 'Get List Items  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Location'
    snippet: 'Get Location'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Matching Xpath Count'
    snippet: 'Get Matching Xpath Count  ${1:xpath}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Selected List Label'
    snippet: 'Get Selected List Label  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Selected List Labels'
    snippet: 'Get Selected List Labels  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Selected List Value'
    snippet: 'Get Selected List Value  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Selected List Values'
    snippet: 'Get Selected List Values  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Selenium Implicit Wait'
    snippet: 'Get Selenium Implicit Wait'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Selenium Speed'
    snippet: 'Get Selenium Speed'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Selenium Timeout'
    snippet: 'Get Selenium Timeout'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Source'
    snippet: 'Get Source'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Table Cell'
    snippet: 'Get Table Cell  ${1:table_locator}  ${2:row}  ${3:column}  ${4:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Text'
    snippet: 'Get Text  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Title'
    snippet: 'Get Title'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Value'
    snippet: 'Get Value  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Vertical Position'
    snippet: 'Get Vertical Position  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Window Identifiers'
    snippet: 'Get Window Identifiers'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Window Names'
    snippet: 'Get Window Names'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Window Size'
    snippet: 'Get Window Size'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Get Window Titles'
    snippet: 'Get Window Titles'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Go Back'
    snippet: 'Go Back'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Go To'
    snippet: 'Go To  ${1:url}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Input Password'
    snippet: 'Input Password  ${1:locator}  ${2:text}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Input Text'
    snippet: 'Input Text  ${1:locator}  ${2:text}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'List Selection Should Be'
    snippet: 'List Selection Should Be  ${1:locator}  ${2:*items}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'List Should Have No Selections'
    snippet: 'List Should Have No Selections  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Location Should Be'
    snippet: 'Location Should Be  ${1:url}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Location Should Contain'
    snippet: 'Location Should Contain  ${1:expected}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Locator Should Match X Times'
    snippet: 'Locator Should Match X Times  ${1:locator}  ${2:expected_locator_count}  ${3:message=}  ${4:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Log Location'
    snippet: 'Log Location'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Log Source'
    snippet: 'Log Source  ${1:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Log Title'
    snippet: 'Log Title'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Maximize Browser Window'
    snippet: 'Maximize Browser Window'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Mouse Down'
    snippet: 'Mouse Down  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Mouse Down On Image'
    snippet: 'Mouse Down On Image  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Mouse Down On Link'
    snippet: 'Mouse Down On Link  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Mouse Out'
    snippet: 'Mouse Out  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Mouse Over'
    snippet: 'Mouse Over  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Mouse Up'
    snippet: 'Mouse Up  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Open Browser'
    snippet: 'Open Browser  ${1:url}  ${2:browser=firefox}  ${3:alias=None}  ${4:remote_url=False}  ${5:desired_capabilities=None}  ${6:ff_profile_dir=None}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Open Context Menu'
    snippet: 'Open Context Menu  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Contain'
    snippet: 'Page Should Contain  ${1:text}  ${2:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Contain Button'
    snippet: 'Page Should Contain Button  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Contain Checkbox'
    snippet: 'Page Should Contain Checkbox  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Contain Element'
    snippet: 'Page Should Contain Element  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Contain Image'
    snippet: 'Page Should Contain Image  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Contain Link'
    snippet: 'Page Should Contain Link  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Contain List'
    snippet: 'Page Should Contain List  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Contain Radio Button'
    snippet: 'Page Should Contain Radio Button  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Contain Textfield'
    snippet: 'Page Should Contain Textfield  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Not Contain'
    snippet: 'Page Should Not Contain  ${1:text}  ${2:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Not Contain Button'
    snippet: 'Page Should Not Contain Button  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Not Contain Checkbox'
    snippet: 'Page Should Not Contain Checkbox  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Not Contain Element'
    snippet: 'Page Should Not Contain Element  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Not Contain Image'
    snippet: 'Page Should Not Contain Image  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Not Contain Link'
    snippet: 'Page Should Not Contain Link  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Not Contain List'
    snippet: 'Page Should Not Contain List  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Not Contain Radio Button'
    snippet: 'Page Should Not Contain Radio Button  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Page Should Not Contain Textfield'
    snippet: 'Page Should Not Contain Textfield  ${1:locator}  ${2:message=}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Press Key'
    snippet: 'Press Key  ${1:locator}  ${2:key}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Radio Button Should Be Set To'
    snippet: 'Radio Button Should Be Set To  ${1:group_name}  ${2:value}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Radio Button Should Not Be Selected'
    snippet: 'Radio Button Should Not Be Selected  ${1:group_name}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Register Keyword To Run On Failure'
    snippet: 'Register Keyword To Run On Failure  ${1:keyword}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Reload Page'
    snippet: 'Reload Page'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Select All From List'
    snippet: 'Select All From List  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Select Checkbox'
    snippet: 'Select Checkbox  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Select Frame'
    snippet: 'Select Frame  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Select From List'
    snippet: 'Select From List  ${1:locator}  ${2:*items}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Select From List By Index'
    snippet: 'Select From List By Index  ${1:locator}  ${2:*indexes}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Select From List By Label'
    snippet: 'Select From List By Label  ${1:locator}  ${2:*labels}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Select From List By Value'
    snippet: 'Select From List By Value  ${1:locator}  ${2:*values}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Select Radio Button'
    snippet: 'Select Radio Button  ${1:group_name}  ${2:value}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Select Window'
    snippet: 'Select Window  ${1:locator=None}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Set Browser Implicit Wait'
    snippet: 'Set Browser Implicit Wait  ${1:seconds}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Set Selenium Implicit Wait'
    snippet: 'Set Selenium Implicit Wait  ${1:seconds}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Set Selenium Speed'
    snippet: 'Set Selenium Speed  ${1:seconds}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Set Selenium Timeout'
    snippet: 'Set Selenium Timeout  ${1:seconds}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Set Window Size'
    snippet: 'Set Window Size  ${1:width}  ${2:height}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Simulate'
    snippet: 'Simulate  ${1:locator}  ${2:event}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Submit Form'
    snippet: 'Submit Form  ${1:locator=None}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Switch Browser'
    snippet: 'Switch Browser  ${1:index_or_alias}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Table Cell Should Contain'
    snippet: 'Table Cell Should Contain  ${1:table_locator}  ${2:row}  ${3:column}  ${4:expected}  ${5:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Table Column Should Contain'
    snippet: 'Table Column Should Contain  ${1:table_locator}  ${2:col}  ${3:expected}  ${4:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Table Footer Should Contain'
    snippet: 'Table Footer Should Contain  ${1:table_locator}  ${2:expected}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Table Header Should Contain'
    snippet: 'Table Header Should Contain  ${1:table_locator}  ${2:expected}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Table Row Should Contain'
    snippet: 'Table Row Should Contain  ${1:table_locator}  ${2:row}  ${3:expected}  ${4:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Table Should Contain'
    snippet: 'Table Should Contain  ${1:table_locator}  ${2:expected}  ${3:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Textarea Should Contain'
    snippet: 'Textarea Should Contain  ${1:locator}  ${2:expected}  ${3:message=}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Textarea Value Should Be'
    snippet: 'Textarea Value Should Be  ${1:locator}  ${2:expected}  ${3:message=}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Textfield Should Contain'
    snippet: 'Textfield Should Contain  ${1:locator}  ${2:expected}  ${3:message=}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Textfield Value Should Be'
    snippet: 'Textfield Value Should Be  ${1:locator}  ${2:expected}  ${3:message=}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Title Should Be'
    snippet: 'Title Should Be  ${1:title}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Unselect Checkbox'
    snippet: 'Unselect Checkbox  ${1:locator}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Unselect Frame'
    snippet: 'Unselect Frame'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Unselect From List'
    snippet: 'Unselect From List  ${1:locator}  ${2:*items}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Unselect From List By Index'
    snippet: 'Unselect From List By Index  ${1:locator}  ${2:*indexes}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Unselect From List By Label'
    snippet: 'Unselect From List By Label  ${1:locator}  ${2:*labels}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Unselect From List By Value'
    snippet: 'Unselect From List By Value  ${1:locator}  ${2:*values}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Wait For Condition'
    snippet: 'Wait For Condition  ${1:condition}  ${2:timeout=None}  ${3:error=None}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Wait Until Element Is Visible'
    snippet: 'Wait Until Element Is Visible  ${1:locator}  ${2:timeout=None}  ${3:error=None}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Wait Until Page Contains'
    snippet: 'Wait Until Page Contains  ${1:text}  ${2:timeout=None}  ${3:error=None}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Wait Until Page Contains Element'
    snippet: 'Wait Until Page Contains Element  ${1:locator}  ${2:timeout=None}  ${3:error=None}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
  {
    text: 'Xpath Should Match X Times'
    snippet: 'Xpath Should Match X Times  ${1:xpath}  ${2:expected_xpath_count}  ${3:message=}  ${4:loglevel=INFO}'
    rightLabel: 'Selenium2Library'
    type: 'function'
  }
]

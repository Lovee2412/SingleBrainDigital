*** Settings ***
Library    SeleniumLibrary    

*** Variables ***
${browserName}                  chrome
${downloadDir}                ${EXECDIR}${/}LinkedInDeMo${/}Assets${/}Input
${time}                       20s

*** Keywords ***
common Open brower
    [Arguments]        ${url}
    ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver 
    ${prefs}  Create Dictionary   download.default_directory=${downloadDir}
    Call Method  ${chrome_options}  add_experimental_option  prefs  ${prefs} 
    Call Method    ${chrome_options}    add_argument    --disable-gpu 
    #Call Method    ${chrome_options}    add_argument    --headless
    #Call Method    ${chrome_options}    setPageLoadStrategy     PageLoadStrategy.NORMAL
    Log To Console    ${EXECDIR}${/}      
    ${desired_caps}=  Create Dictionary  browserName=${browserName}  
    Open Browser   url=${url}  browser=chrome   desired_capabilities=${desired_caps}  options=${chrome_options}  executable_path=${EXECDIR}${/}LinkedInDemo${/}chromedriver.exe 

Common Click element
    [Arguments]    ${elementname}    ${xpath}    
    Wait Until Element Is Visible    ${xpath}     ${time}
    Wait Until Element Is Enabled    ${xpath}     ${time}
    Click Element    ${xpath}    
    run keyword if  '${elementname}'!='${empty}'  Log To Console    ${elementname} 
    
Common Input Text
    [Arguments]    ${elementname}    ${xpath}    ${value}
    Wait Until Element Is Visible    ${xpath}     ${time}
    Wait Until Element Is Enabled    ${xpath}     ${time}    
    Input Text    ${xpath}    ${value}     
    run keyword if  '${elementname}'!='${empty}'  Log To Console    ${elementname}          

common get text 
    [Arguments]    ${elementname}    ${xpath}    
    Wait Until Element Is Visible    ${xpath}     ${time}
    Wait Until Element Is Enabled    ${xpath}     ${time}
    ${text}=   get text    ${xpath}
    Log To Console    ${elementname}    
    [Return]    ${text}
    
Common Input Password
    [Arguments]    ${elementname}    ${xpath}    ${value}
    Wait Until Element Is Visible    ${xpath}     ${time}
    Wait Until Element Is Enabled    ${xpath}     ${time}    
    Input Password    ${xpath}    ${value}     
    Log To Console    ${elementname}          

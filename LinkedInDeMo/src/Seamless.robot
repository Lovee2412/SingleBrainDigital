*** Settings ***
Library    ExcelLibrary
Library    SeleniumLibrary    
Library    Collections 

*** Variables ***
${Seamless_URL}   https://login.seamless.ai/
${comapnyWebsite}     ${empty}

*** Keywords ***
login to seamless 
    [Arguments]    ${username}     ${password}
    common Open brower   ${Seamless_URL}
    Maximize Browser Window
    common input text  Entering User Name   //input[@name="username"]     ${username}
    common Input Password   Entering Password     //input[@name="password"]     ${password}
    common click element  Clicking Login Button  //button[contains(text(),'Login')] 
    Wait Until Element Is Visible      //a[contains(@href,"/search/companies")]    20s
        

navigate to company 
    Wait Until Element Is Visible      //a[contains(@href,"/search/companies")]    30s   
    Wait Until Page Contains Element   //a[contains(@href,"/search/companies")]    30s
    sleep  3s
    Execute Javascript    window.scrollTo(0,80); 
    common Click Element  ${empty}   //a[contains(@href,"/search/companies")]
     
        

Search company deatils
    [Arguments]   ${brandname}    ${execfilename}
    
    #Write logs  ${execfilename}    Comapny Name: ${brandname}       
    Wait Until Page Contains Element    //input[contains(@placeholder,'Nike')]   5s   
    click element   //button[contains(text(),'Clear All')] 
    Execute JavaScript    window.document.evaluate("//span[@class='rs-checkbox-wrapper']//input", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.scrollIntoView(true);
    sleep  2s
    Wait Until Keyword Succeeds    2x    2    input text      //input[contains(@placeholder,'Nike')]          ${brandname} 
    Press Keys    //input[contains(@placeholder,'Nike')]        RETURN
    Click Element    //div[contains(@class,"SearchFilters__FooterContainer-jyFVxH")]//button[contains(text(),'Search')]    
    ${status}=   Run Keyword And Return Status   Wait Until Page Contains Element    (//div[@class="columnStyles__ColumnData-hFzXYE columnStyles__ColumnDataBtn-gXdDYw euBUkY fKMXCr"])[1]   30s    
    Run Keyword If    '${status}'=='False'    Return From Keyword    False
    ${website}=   get text   (//div[@class="columnStyles__ColumnData-hFzXYE columnStyles__ColumnDataBtn-gXdDYw euBUkY fKMXCr"])[1] 
    #Log To Console    Company Website : ${website}    
    Set Global Variable    ${comapnyWebsite}       ${website} 
    Execute Javascript    window.scrollTo(0,90); 
    Click Element    (//button[@class="rs-btn rs-btn-primary Button__StyledButton-iEKVQz jmdkgz" and contains(text(),'Find')])[1]
    Write logs  ${execfilename}   Company Website = ${website}
    [Return]    True
    
Search Person details  
    [Arguments]    ${position1}   ${position2}    ${filename}     ${rowcount}   ${outputcolstart}  ${execfilename}
    wait until page contains element  (//input[contains(@class,"rs-input Input__StyledInput-hFpMqr hdEkfK")])[1]  20s
    Wait Until Element Is Enabled     (//input[contains(@class,"rs-input Input__StyledInput-hFpMqr hdEkfK")])[1]   30s   
    input text   (//input[contains(@class,"rs-input Input__StyledInput-hFpMqr hdEkfK")])[1]        ${position1}
    Press Keys  (//input[contains(@class,"rs-input Input__StyledInput-hFpMqr hdEkfK")])[1]    RETURN
    input text   (//input[contains(@class,"rs-input Input__StyledInput-hFpMqr hdEkfK")])[1]    ${position2}
    Press Keys  (//input[contains(@class,"rs-input Input__StyledInput-hFpMqr hdEkfK")])[1]    RETURN
    click element   //div[contains(@class,"SearchFilters__FooterContainer-jyFVxH")]//button[contains(text(),'Search')] 
    ${status2}=   Run Keyword And Return Status   Wait Until Page Contains Element     (//td[6]//div//button[contains(.,'Find')])[1]    5s        
    Run Keyword If    '${status2}'=='False'    Return From Keyword    False    
    Run Keyword And Continue On Failure    Wait Until Page Contains Element    (//td[6]//div//button[contains(.,'Find')])[1]    10s 
    Run Keyword And Continue On Failure   Click Element    (//td[6]//div//button[contains(.,'Find')])[1]           
    Wait Until Page Contains Element    //div[contains(@class,"ContactColumn__ContactTitle-geIBRO")]//parent::div/preceding-sibling::div/button   30s
    ${name}=  Get Text   //div[contains(@class,"ContactColumn__ContactTitle-geIBRO")]//parent::div/preceding-sibling::div/button
    ${role}     get text  //div[contains(@class,"ContactColumn__ContactTitle-geIBRO")]
    ${count}=  Get Element Count    //td[4]//div//div//div//div
    ${details}=  Create List     
    FOR  ${in}  IN RANGE  1  ${count}
          ${value}=  Run Keyword And Continue On Failure  get text        (//td[4]//div//div//div//div)[${in}]
          Append To List    ${details}          ${value}
    END
        
    ${linkedin}=  Run Keyword And Continue On Failure   Get Element Attribute   //td[5]//div//div//a[contains(@href,'linkedin')]    href
    ${facebook}=  Run Keyword And Continue On Failure   Get Element Attribute   //td[5]//div//div//a[contains(@href,'facebook')]    href
    ${companyLocation}=  Run Keyword And Continue On Failure   get text  (//td[5]//div//div[2]//div//div)[1]
    ${personalLocation}=  Run Keyword And Continue On Failure   get text    (//td[5]//div//div[2]//div//div)[2]    
    #Click Element    //button[@class="SearchFilterField__CloseTagBtn-dQzlwk dTorrn"]//parent::div/div[contains(.,'${position1}')]   
    click element   //div[contains(@class,"SearchFilters__FooterContainer-jyFVxH")]//button[contains(text(),'Search')]   
    ${count1}  Get Match Count  ${details}  *\@*
    ${emails}=   Get Matches    ${details}    *\@*   
    ${cell}=   get matches    ${details}   *[0-9]

    Write logs    ${execfilename}  Name : ${name}
    Write logs    ${execfilename}  Position : ${role}  #Position : ${role}
    Run Keyword And Continue On Failure  Write logs    ${execfilename}  Bussiness Email:${emails}[0]
    Run Keyword And Continue On Failure  Write logs    ${execfilename}  Personal Email:${emails}[1]
    Run Keyword And Continue On Failure  Write logs    ${execfilename}  Bussiness Cell :${cell}[0]
    Run Keyword And Continue On Failure  Write logs    ${execfilename}  Personal Cell :${cell}[1]
    Write logs    ${execfilename}  LinkedIN : ${linkedin}
    Write logs    ${execfilename}  Facebook : ${facebook}
    Write logs    ${execfilename}  Company location : ${companyLocation}
    Write logs    ${execfilename}  Personal Location: ${personalLocation}
     
     
     ${ContactPerseoncol}=  Evaluate     ${outputColstart}+12
     ${positionCol}=  Evaluate     ${outputColstart}+13
     ${BussinessEmailCol}=  Evaluate     ${outputColstart}+14
     ${personalEmailCol}=   Evaluate     ${outputColstart}+15
     ${bussinessCellCol}=  Evaluate     ${outputColstart}+16
     ${PersonalCellcol}=     Evaluate     ${outputColstart}+17
     ${LinkedinProfileCol}=  Evaluate     ${outputColstart}+18
     ${FacebookCol}=  Evaluate     ${outputColstart}+19
     ${CompanyLocationCol}=  Evaluate     ${outputColstart}+20
     ${PersonalLocationCol}=  Evaluate     ${outputColstart}+21 
     ${companywebsitesealesscol}=   Evaluate     ${outputColstart}+1   

     Open Excel Document     ${filename}    doc_id=input5
     Write Excel Cell    ${rowcount}    ${ContactPerseoncol}     ${name}
     Write Excel Cell   ${rowcount}    ${positionCol}          ${role}
     Run Keyword And Continue On Failure    Write Excel Cell   ${rowcount}    ${BussinessEmailCol}    ${emails}[0]
     Run Keyword And Continue On Failure    Write Excel Cell   ${rowcount}    ${personalEmailCol}     ${emails}[1]
     Run Keyword And Continue On Failure    Write Excel Cell   ${rowcount}    ${bussinessCellCol}    ${cell}[0] 
     Run Keyword And Continue On Failure    Write Excel Cell   ${rowcount}    ${PersonalCellcol}     ${cell}[1]
     Write Excel Cell   ${rowcount}    ${LinkedinProfileCol}   ${linkedin}
     Write Excel Cell   ${rowcount}    ${FacebookCol}          ${facebook}
     Write Excel Cell   ${rowcount}    ${CompanyLocationCol}   ${companyLocation}
     Write Excel Cell   ${rowcount}    ${PersonalLocationCol}  ${personalLocation}
     Write Excel Cell   ${rowcount}    ${companywebsitesealesscol}  ${comapnyWebsite}
     Save Excel Document    ${filename} 
     Close Current Excel Document 
    [Return]    True
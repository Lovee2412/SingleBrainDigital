*** Settings ***
Library    SeleniumLibrary   
Library    ExcelLibrary 
Resource    SmartScoutapp.robot


*** Variables ***
${linkedin_URL}            https://www.linkedin.com/
@{BrandName}               Utzy Naturals    Lifoam    Aulterra    YoRo Naturals    MPM Medical    Cured Nutrition    Corflex    Nutriumph    Provenza Floors
...    BRUSHEAN    Pure and Clean    Anchor Packaging    Extend Nutrition    Purple Rose Supply    Seattle Elderberry LLC    Java Jacket

${username}                lavanyaballa24@gmail.com
${password}                lavisha@143
${outputExcelPath}         ${EXECDIR}${/}output${/}demo.xlsx
${index}                   2
 
${googleURL}               https://www.google.com/

*** Keywords ***

login to LinkedIn
    [Arguments]    ${username}   ${password}
    common Open brower    ${linkedin_URL}
    Log to console   Linkedin Url is opened    
    Maximize Browser Window
    common Input Text  Entering User name  //input[@autocomplete="username"]    ${username}
    common Input Password  ENtering user password  //input[@autocomplete="current-password"]      ${password}
    common Click Element  Clicking on signin  //button[contains(text(),'Sign in')]        

Search by company name
    [Arguments]    ${company_name}
    Wait Until Page Contains Element        //input[@placeholder="Search"]    60s
    common Input Text  ${empty}  //input[@placeholder="Search"]    ${company_name}
    Press Keys   //input[@placeholder="Search"]  RETURN  
            
   # Run Keyword If   '${st}'=='False'      Return From Keyword    
    Run Keyword And Continue On Failure  Wait Until Page Contains     People      40s      
    Wait Until Page Contains    Companies   40s
    #Wait Until Page Contains Element        //button[contains(.,'Companies')]       40s
    common Click Element  ${empty}   //button[contains(.,'Companies')]
    ${st}=  Run Keyword And Return Status    Wait Until Page Contains Element    //h1[text()='No results found']  5s
    #log to console    no result status = ${st}   
    Run Keyword If   '${st}'=='True'      Return From Keyword   False
    #Wait Until Page Contains Element    //span[@class="entity-result__title-text${SPACE}${SPACE}t-16"]  60s        
    ${status}=   Run Keyword And Return Status  common Click Element  ${empty}  //span[@class="entity-result__title-text${SPACE}${SPACE}t-16"] 
    [Return]    ${status}

serach for people
    [Arguments]    ${company_name}
    #Wait Until Page Contains Element        //input[@placeholder="Search"]    60s
    Input Text    //input[@placeholder="Search"]    ${company_name}
    Press Keys   //input[@placeholder="Search"]  RETURN  
    Wait Until Page Contains    People      40s      
    Wait Until Page Contains    Companies   40s
    Wait Until Page Contains Element       //button[contains(.,'People')]        50s
    click element     //button[contains(.,'People')]
    


get company details
    [Arguments]  ${name}    ${index}  ${inputFilePath}   ${outputcolstart}
    Open Excel Document    ${inputFilePath}    doc_id=input5
    Wait Until Page Contains Element       //a[contains(@href,'about') and contains(.,'About')]   40s
    Run Keyword And Continue On Failure    click element    //a[contains(@href,'about') and contains(.,'About')]    
    Run Keyword And Continue On Failure    Wait Until Page Contains Element    //span[contains(.,'See all details')]  20s     
    Run Keyword And Continue On Failure    Click Element     //span[contains(.,'See all details')] 
    Run Keyword And Continue On Failure    Wait Until Page Contains Element    (//a[@rel="noopener noreferrer"])[2]    20s       
    ${company_url}  Run Keyword And Continue On Failure  Get Element Attribute   (//a[@rel="noopener noreferrer"])[2]   href      
    Log To Console    CompanyURL = ${company_url} 
    ${company_linkedin}=  Get Location
    Log To Console    LinkedinURL = ${company_linkedin}
    Run Keyword If  '${company_url}'=='None'   Return From Keyword    
    Go To    ${company_url}
    #Switch Current Excel Document    ${id} 
    ${companywebsitecol}=    Evaluate    ${outputcolstart}+1     
    Write Excel Cell    ${index}    ${companywebsitecol}    ${company_url} 
    ${linkedurlcol}=    Evaluate    ${outputcolstart}+2
    Write Excel Cell    ${index}    ${linkedurlcol}    ${company_linkedin}  
    Save Excel Document    ${inputFilePath}
    Run Keyword And Continue On Failure  Wait Until Page Contains Element       //a[contains(@href,'facebook')]    20s  
    ${facebook}=  Run Keyword And Continue On Failure  Get Element Attribute    //a[contains(@href,'facebook')]    href
    Log To Console    Facebook = ${facebook} 
    ${facebookurlcol}=    Evaluate    ${outputcolstart}+3
    Write Excel Cell    ${index}    ${facebookurlcol}    ${facebook}  
    Run Keyword And Continue On Failure  Wait Until Page Contains Element        //a[contains(@href,'instagram')]    10s
    ${instagram}=  Run Keyword And Continue On Failure  Get Element Attribute    //a[contains(@href,'instagram')]    href
    Log To Console    Instagram = ${instagram}
    ${instagramurlcol}=    Evaluate    ${outputcolstart}+4
    Write Excel Cell    ${index}    ${instagramurlcol}    ${instagram}  
    Go to  ${linkedin_URL}
    Save Excel Document    ${inputFilePath} 
    Close Current Excel Document      
      


    
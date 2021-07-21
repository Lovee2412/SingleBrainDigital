*** Settings ***
Library    SeleniumLibrary   
Library    ExcelLibrary 
Resource    SmartScoutapp.robot

*** Variables ***
${linkedin_URL}            https://www.linkedin.com/
@{BrandName}               Utzy Naturals    Lifoam    Aulterra    YoRo Naturals    MPM Medical    Cured Nutrition    Corflex    Nutriumph    Provenza Floors
...    BRUSHEAN    Pure and Clean    Anchor Packaging    Extend Nutrition    Purple Rose Supply    Seattle Elderberry LLC    Java Jacket
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
#    sleep    60s  

Search by company name
    [Arguments]    ${company_name}
    Wait Until Page Contains Element        //input[contains(@placeholder,"Search")]    60s
    common Input Text  ${empty}   //input[contains(@placeholder,"Search")]    ${company_name}
    Press Keys    //input[contains(@placeholder,"Search")]   RETURN         
    Run Keyword And Continue On Failure  Wait Until Page Contains     People      20s      
    sleep  3s
    Wait Until Page Contains Element        //button[@aria-label="Companies"]     50s
    sleep  1s
    click element   //button[@aria-label="Companies"]
    Log to console  After clicking companies
    ${st}=  Run Keyword And Return Status    Page Should Contain Element    //h1[text()='No results found'] 
    Run Keyword If   '${st}'=='True'      Return From Keyword   False
    ${st1}=  Run Keyword And Return Status   Page Should Contain Element    //div[@class="t-14 t-black--light" and contains(.,'No results for')]       
    Run Keyword If    '${st1}'=='True'    Return From Keyword   False        
    ${status}=   Run Keyword And Return Status  common Click Element  ${empty}  //span[@class="entity-result__title-text${SPACE}${SPACE}t-16"] 
    [Return]    ${status}




get company details
    [Arguments]  ${name}    ${index}  ${inputFilePath}   ${outputcolstart}   ${excefilename}
    Wait Until Page Contains Element       //a[contains(@href,'about') and contains(.,'About')]   40s
    Run Keyword And Continue On Failure    click element    //a[contains(@href,'about') and contains(.,'About')]    
    Run Keyword And Continue On Failure    Wait Until Page Contains Element    //span[contains(.,'See all details')]  20s     
    Run Keyword And Continue On Failure    Click Element     //span[contains(.,'See all details')] 
    Run Keyword And Continue On Failure    Wait Until Page Contains Element    (//a[@rel="noopener noreferrer"])[2]    20s       
    ${company_url}  Run Keyword And Continue On Failure  Get Element Attribute   (//a[@rel="noopener noreferrer"])[2]   href      
    Write logs  ${excefilename}    CompanyURL = ${company_url} 
    ${company_linkedin}=  Get Location
    Write logs  ${excefilename}    LinkedinURL = ${company_linkedin}
    Run Keyword If  '${company_url}'=='None'   Return From Keyword    
    Go To    ${company_url}
    Reload Page
    Open Excel Document    ${inputFilePath}    doc_id=input5
    ${companywebsitecol}=    Evaluate    ${outputcolstart}+1     
    Write Excel Cell    ${index}    ${companywebsitecol}    ${company_url} 
    ${linkedurlcol}=    Evaluate    ${outputcolstart}+2
    Write Excel Cell    ${index}    ${linkedurlcol}    ${company_linkedin}  
    Save Excel Document    ${inputFilePath}
    Run Keyword And Continue On Failure  Wait Until Page Contains Element       //a[contains(@href,'facebook')]    10s  
    ${facebook}=  Run Keyword And Continue On Failure  Get Element Attribute    //a[contains(@href,'facebook')]    href
     Write logs  ${excefilename}    Facebook = ${facebook} 
    ${facebookurlcol}=    Evaluate    ${outputcolstart}+3
    Write Excel Cell    ${index}    ${facebookurlcol}    ${facebook}  
    Run Keyword And Continue On Failure  Wait Until Page Contains Element        //a[contains(@href,'instagram')]    5s
    ${instagram}=  Run Keyword And Continue On Failure  Get Element Attribute    //a[contains(@href,'instagram')]    href
     Write logs  ${excefilename}   Instagram = ${instagram}
    ${instagramurlcol}=    Evaluate    ${outputcolstart}+4
    Write Excel Cell    ${index}    ${instagramurlcol}    ${instagram}  
    #Go to  ${linkedin_URL}
    Save Excel Document    ${inputFilePath} 
    Close Current Excel Document      
      


    
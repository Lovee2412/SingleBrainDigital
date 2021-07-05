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
    [Arguments]  ${name}  ${id}  ${index}  ${inputFilePath}   ${outputcolstart}
    Wait Until Page Contains Element       //a[contains(@href,'about') and contains(.,'About')]   40s
    Run Keyword And Continue On Failure    Wait Until Page Contains Element    //span[contains(.,'See all details')]  40s     
    Run Keyword And Continue On Failure    common Click Element  ${empty}   //span[contains(.,'See all details')] 
    Run Keyword And Continue On Failure    Wait Until Page Contains Element    (//a[@rel="noopener noreferrer"])[2]    20s       
    ${company_url}  Run Keyword And Continue On Failure  Get Element Attribute   (//a[@rel="noopener noreferrer"])[2]   href      
    Log To Console    CompanyURL = ${company_url} 
    ${company_linkedin}=  Get Location
    Log To Console    LinkedinURL = ${company_linkedin}
    Run Keyword If  '${company_url}'=='None'   Return From Keyword    
    Go To    ${company_url}
    Switch Current Excel Document    ${id} 
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
    Run Keyword And Continue On Failure  Wait Until Page Contains Element        //a[contains(@href,'instagram')]    20s
    ${instagram}=  Run Keyword And Continue On Failure  Get Element Attribute    //a[contains(@href,'instagram')]    href
    Log To Console    Instagram = ${instagram}
    ${instagramurlcol}=    Evaluate    ${outputcolstart}+4
    Write Excel Cell    ${index}    ${instagramurlcol}    ${instagram}  
    Go to  ${linkedin_URL}
    Save Excel Document    ${inputFilePath}       
      

# Find contact person details
    # [Arguments]        ${brandname}   ${keyword}
    # Open Browser    ${googleURL}        gc    
    # Maximize Browser Window
    # Wait Until Page Contains Element    //input[@name="q"]        30s
    # Input Text                          //input[@name="q"]        ${keyword} At ${brandname} linkedin
    # Press Keys                          //input[@name="q"]        RETURN
    # ${status}=    Run Keyword And Return Status  Wait Until Page Contains Element    //a[contains(@href,'www.linkedin.com')]    40s
    # Run Keyword If  '${status}'=='True'    Click Element                       //a[contains(@href,'www.linkedin.com')]
    # ...     ELSE     Click Element                       //a[contains(@href,'ca.linkedin.com')]
    # Wait Until Page Contains Element    //p//button[contains(.,'Sign in')]         40s
    # Click Element                       //p//button[contains(.,'Sign in')]    
    # Wait Until Page Contains Element    //input[@id="login-email"]                 40s
    # input text                          //input[@id="login-email"]                 ${username}
    # input text                          //input[@id="login-password"]              lavisha@143    
    # click element                       //button[@id="login-submit"]
    # ${personname}=                      Get Text                                   //h1[@class="text-heading-xlarge inline t-24 v-align-middle break-words"]  
    # log to console                      Person Name = ${personname}
    # ${position}=                        get text                                   //div[@class="text-body-medium break-words"]
    # log to console                      Position = ${position}
    # ${PersonlinkedInUrl}=               Get Location       
    # Log To Console                      Person linkedin = ${PersonlinkedInUrl} 
    # Wait Until Page Contains Element    //a[contains(.,'Contact info')]            40s
    # Click Element                       //a[contains(.,'Contact info')]
   # # Go To                               ${googleURL} 
    
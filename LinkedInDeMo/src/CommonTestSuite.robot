*** Settings ***
Resource    LinkedIN.robot 
Resource    SmartScoutapp.robot
Resource    SimilarTechapp.robot
Resource    Seamless.robot
library     ExcelLibrary 
Library     SeleniumLibrary
Library     OperatingSystem    
Library     DateTime  
Library     String  
Test Teardown       CleanUp
 

*** Variables ***
${inputfilepath}    ${empty}

      

*** Test Cases ***
SmartScout 
  smartscout for multiple category

PrepareExcel 
   Prepare Output Excel
    
Linkedin    
    linkedin Flow
     
SimilarTech 
    SimilarTech excel Demo
    
Seamless
    SeamlessDemo

CompanyDetails
    Company details
     
*** Keywords ***

smartscout for multiple category
    Log To Console    ${EMPTY} 
    Open Excel Document    ${inputfilepath}    doc_id=input1   
    ${username}=  Read Excel Cell    3    3 
    ${Password}=  Read Excel Cell    4    3  
    ${avg_selling_price}=   Read Excel Cell    5    3 
    ${monthly_revenue_start}=   Read Excel Cell    6    3
    ${monthly_revenue_end}=  Read Excel Cell    7    3
    ${amazonStockRate}=  Read Excel Cell    8    3     
    ${avgsellerStart}=  Read Excel Cell    9    3
    ${avgsellerend}=     Read Excel Cell    10    3
    ${brandscorestart}=  Read Excel Cell    11    3
    ${brandscoreend}=   Read Excel Cell    12    3
    ${category}=  Read Excel Cell    13    3  
    
    
    ${excefilename}=   Create Excecution file   SmartScout
    Log to console   Log file name= ${excefilename}
    Append to file    ${excefilename}    content=[Start]\n 
    Write logs  ${excefilename}    *********************************************************    
    Write logs  ${excefilename}    Starting SmartScout
    Write logs  ${excefilename}    Download path = ${downloadDir}    
    Write logs  ${excefilename}    Reading data from = ${inputfilepath} 
    Write logs  ${excefilename}    SmartScout User Name = ${username}   
    Write logs  ${excefilename}    SmartScout User Password = ${Password}
    Write logs  ${excefilename}    Average Selling Price = ${avg_selling_price}
    Write logs  ${excefilename}    Monthly Revenue Start = ${monthly_revenue_start}     
    Write logs  ${excefilename}    Monthly Revenue End = ${monthly_revenue_end}    
    Write logs  ${excefilename}    Amazon Stock Rate = ${amazonStockRate}    
    Write logs  ${excefilename}    Average Seller Start = ${avgsellerStart}    
    Write logs  ${excefilename}    Average Seller End = ${avgsellerend}
    Write logs  ${excefilename}    Brand Score Start = ${brandscorestart}    
    Write logs  ${excefilename}    Brand Score End = ${brandscoreend} 
    Write logs  ${excefilename}    Category = ${category}              
    
    Wait Until Keyword Succeeds  2x  2s   smartscout flow  ${username}   ${password}   ${category}   ${amazonStockRate}  ${avgsellerStart}  ${avgsellerend}  ${avg_selling_price}
    ...  ${monthly_revenue_start}  ${monthly_revenue_end}  ${brandscorestart}  ${brandscoreend}
    Write logs  ${excefilename}    Download directory = ${downloadDir}   
    @{filename}=   List Files In Directory    ${downloadDir}
    ${date}=   Get Current Date    
    ${date} =	Convert Date	${date}	  result_format=%d%m%Y%H%M%S
    move file  ${downloadDir}${/}${filename}[0]    ${downloadDir}${/}SmartScout_${category}${date}.xlsx
    write excel cell  14   3   ${downloadDir}${/}SmartScout_${category}${date}.xlsx
    Write logs  ${excefilename}    Exported file name=${downloadDir}${/}SmartScout_${category}${date}.xlsx
    Save Excel Document    ${inputfilepath}
    Close All Excel Documents
    Write logs  ${excefilename}    *********************************************************
    Append to file    ${excefilename}    content=[END]\n  

Prepare Output Excel
     Log To Console    ${empty}  
     ${excefilename}=   Create Excecution file  SmartScout
     Append to file    ${excefilename}    content=[Start]\n   
     Write logs  ${excefilename}   *********************************************************
     Write logs  ${excefilename}   preparing excel file with header column
     Open Excel Document    ${inputfilepath}    doc_id=input2
     ${filename}=   Read Excel Cell    14      3 
     ${outputcolstart}=  read excel cell  6   6
     Close Current Excel Document          
     Open Excel Document   ${filename}    doc_id=input3  
     ${companywebsitecol}=    Evaluate    ${outputcolstart}+1     
     Write Excel Cell    1    ${companywebsitecol}    Company Website
     ${linkedurlcol}=    Evaluate    ${outputcolstart}+2
     Write Excel Cell    1    ${linkedurlcol}    Company LinkedIn Profile
     ${facebookurlcol}=    Evaluate    ${outputcolstart}+3
     Write Excel Cell    1    ${facebookurlcol}    Company Facebook Profile
     ${instagramurlcol}=    Evaluate    ${outputcolstart}+4
     Write Excel Cell    1    ${instagramurlcol}    Company Instagram Profile
     ${monthlycol}=  Evaluate    ${outputColstart}+5    
     ${directcol}=  Evaluate     ${outputColstart}+6
     ${serachcol}=   Evaluate     ${outputColstart}+7    
     ${socialcol}=   Evaluate     ${outputColstart}+8  
     ${displaycol}=   Evaluate     ${outputColstart}+9  
     ${referralscol}=   Evaluate     ${outputColstart}+10  
     ${mailcol}=   Evaluate     ${outputColstart}+11 
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
     ${companywebsitesealesscol}=   Evaluate     ${outputColstart}+22
     Write Excel Cell    1     ${monthlycol}   Monthly Visitors
     Write Excel Cell   1     ${directcol}    Direct       
     Write Excel Cell    1     ${serachcol}    Serach
     Write Excel Cell    1    ${socialcol}    Social
     Write Excel Cell    1     ${referralscol}    Referrals
     Write Excel Cell    1    ${mailcol}         Mail     
     Write Excel Cell    1     ${displaycol}    Display
     Write Excel Cell    1    ${ContactPerseoncol}   Contact Personal
     Write Excel Cell    1    ${positionCol}        Position
     Write Excel Cell    1    ${BussinessEmailCol}    Bussiness Email
     Write Excel Cell    1    ${personalEmailCol}     Personal Email
     Write Excel Cell    1    ${bussinessCellCol}     Bussiness Cell
     Write Excel Cell    1    ${PersonalCellcol}      Personal Cell
     Write Excel Cell    1    ${LinkedinProfileCol}    LinkedIn Profile
     Write Excel Cell    1    ${FacebookCol}          Facebook Profile
     Write Excel Cell    1    ${CompanyLocationCol}   Company Location
     Write Excel Cell    1    ${PersonalLocationCol}   Personal Location
     Write Excel Cell    1    ${companywebsitesealesscol}   Company Website Seamless
     Save Excel Document   ${filename}
     Close Current Excel Document
     Write logs  ${excefilename}    *********************************************************
     Append to file    ${excefilename}    content=[END]\n 


linkedin Flow
    #Set Selenium Speed    1s
    Log To Console    ${empty}
    Open Excel Document    ${inputfilepath}    doc_id=input4    
    ${username}=  Read Excel Cell    3    6
    ${password}=  Read Excel Cell    4    6 
    ${brandcolnum}=  read excel cell   5    6 
    ${outputcolstart}=  Read Excel Cell    6    6
    ${filename}=  read excel cell     14    3
    ${currentrow}=  read excel cell    7   6
    ${category}=   Read Excel Cell    13    3  
    ${noOfRows}=   Read Excel cell    11    6    
    Close Current Excel Document
    
    ${excefilename}=   Create Excecution file  LinkedIn
    Append to file    ${excefilename}    content=[Start]\n 
    Write logs  ${excefilename}    *********************************************************
    Write logs  ${excefilename}    LINKEDIN FLOW STARTING
    Write logs  ${excefilename}    Linked User Name = ${username}
    Write logs  ${excefilename}    Linked User Password     
    Write logs  ${excefilename}    Brand Column No.= ${brandcolnum}
    Write logs  ${excefilename}    Output Column Start No= ${outputcolstart}    
    Write logs  ${excefilename}    Reading data from excel file= ${filename}       
    Write logs  ${excefilename}    Current Row Number= ${currentrow}
    login to LinkedIn   ${username}       ${password}
    
    Open Excel Document    ${filename}    doc_id=input5
    ${list}=    Read Excel Column    ${brandcolnum}  
    Close Current Excel Document
    Create File    ${EXECDIR}${/}LinkedInDeMo${/}Assets${/}Input${/}Logs${/}${category}.txt
    ${len}=   Get Length    ${list}
    Log To Console    Toltal Brands =${len} 
    
    run keyword if  '${noOfRows}'=='None'   Set Local Variable   ${noOfRows}   ${len}
    ${noOfRows}=  Evaluate  ${noOfRows}+1
    FOR    ${count}    IN RANGE   ${currentrow}    ${noOfRows}   #{} 
        Write logs  ${excefilename}    ******************************************    
        Write logs  ${excefilename}    Row Number ${count} Out of Brands ${len}
        Write logs  ${excefilename}    Company Name=${list}[${count}]
        ${lines}=   grep file   ${EXECDIR}${/}LinkedInDeMo${/}Assets${/}Logs${/}${category}.txt   ${list}[${count}]
        ${length}=   Get Length    ${lines}
        ${rowcount}=   Evaluate    ${count}+1    
        Run Keyword If    ${length}!=0     contiune for loop and update count linkedin   ${count}    ${rowcount}  ${len}   ${excefilename}  Brand details already fetched      
        ${status}=  Run Keyword And Continue On Failure  Search by company name  ${list}[${count}]
        Log To Console    ${status}  
        Run Keyword if    '${status}'=='False'   contiune for loop and update count linkedin   ${count}    ${rowcount}  ${len}  ${excefilename}  Brand details not available on LinkedIn
        Run Keyword And Continue On Failure  get company details  ${list}[${count}]  ${rowcount}  ${filename}  ${outputcolstart}   ${excefilename}
        go to  ${linkedin_URL}
        Write logs  ${excefilename}     ******************************************
        Open Excel Document    ${inputfilepath}    doc_id=input4
        Write Excel Cell    7    6    ${rowcount} 
        Write Excel Cell    9    6    ${count}
        ${pending}=  Evaluate   ${len}-${count} 
        Write Excel Cell    10    6    ${pending}
        Write Excel Cell    8    6    ${len} 
        Save Excel Document    ${inputfilepath} 
        Close Current Excel Document  
        Close All Excel Documents
        Append To File    ${EXECDIR}${/}LinkedInDeMo${/}Assets${/}Logs${/}${category}.txt    content=${list}[${count}]\n
    END
    Close All Excel Documents
    Write logs  ${excefilename}   END OF LinkedIn Part
    Write logs  ${excefilename}    *********************************************************
    Append to file    ${excefilename}    content=[END]\n 
    

SimilarTech excel Demo
    log to console   ${empty}
    ${excefilename}=   Create Excecution file  SimilarTech
    Append to file    ${excefilename}    content=[Start]\n 
    Open Excel Document    ${inputFilePath}    doc_id=input6
    ${websitecolno}=  Read Excel Cell    3    9    
    ${filename}=    Read Excel Cell    14    3    
    ${currentcolno}=  Read Excel Cell    4    9 
    ${brandscolno}=   Read Excel Cell    5     6 
    ${outputcolstart}=  Read Excel Cell    6    6    
    ${noofrows}=   Read Excel Cell         8  9
    Close Current Excel Document
    
    Write logs  ${excefilename}    *********************************************************
    Write logs  ${excefilename}    SIMILAR TECH STARTING 
    Write logs  ${excefilename}    Reading data from excel file = ${filename}
    Write logs  ${excefilename}    Company website column no = ${websitecolno}
    
    Open Excel Document    ${filename}    doc_id=input7 
    ${brands}=    Read Excel Column    ${brandscolno}  
    ${list}=    Read Excel Column    ${websitecolno}
    ${len}=   Get Length    ${brands}
    Close Current Excel Document
    
    Write logs  ${excefilename}    Total Brands= ${len}   
    Write logs  ${excefilename}  current Row number= ${currentcolno} 
    
    common Open brower    ${baseURL} 
    ${noOfRows}=  Evaluate  ${noOfRows}+1  
    run keyword if  '${noOfRows}'=='None'   Set Local Variable   ${noOfRows}   ${len}+1  
    FOR    ${count}    IN RANGE  ${currentcolno}          ${noofrows} 
        Write logs  ${excefilename}    ********************************************* 
        Write logs  ${excefilename}    Row Number= ${count}    
        Write logs  ${excefilename}    Company Name=${list}[${count}]  
        ${rowcount}=   Evaluate    ${count}+1 
        Run Keyword If   '${list}[${count}]'=='None'   contiune for loop and update count smililar tech   ${count}    ${rowcount}  ${len}  
        log to console   ${baseURL}${list}[${count}]
        Go To    ${baseURL}${list}[${count}]
        Reload Page
        sleep     3s
        ${status}=   Run Keyword And Return Status    Wait Until Page Contains Element    //div[@class="no-data-available"]   10s      
        run keyword if     '${status}'=='True'  contiune for loop and update count smililar tech  ${count}    ${rowcount}  ${len}  
        SimilarTech    ${filename}  ${rowcount}  ${outputcolstart}   ${excefilename}
        Open Excel Document    ${inputfilepath}    doc_id=id 
        Write Excel Cell    4    9    ${rowcount} 
        Write Excel Cell    6    9    ${count}
        ${pending}=  Evaluate   ${len}-${count}
        Write Excel Cell    7    9   ${pending}
        Write Excel Cell    5    9    ${len}       
        Save Excel Document    ${inputfilepath} 
        Close Current Excel Document
    END
    Close All Excel Documents
    Write logs  ${excefilename}    *********************************************************
    Append to file    ${excefilename}    content=[END]\n

   

contiune for loop and update count linkedin  
    [Arguments]   ${count}   ${rowcount}  ${len}  ${excefilename}   ${message} 
    Write logs  ${excefilename}    ${message} 
    Open Excel Document    ${inputfilepath}    doc_id=input4
    Write Excel Cell    7    6    ${rowcount} 
    Write Excel Cell    9    6    ${count}
    ${pending}=  Evaluate   ${len}-${count} 
    Write Excel Cell    10    6    ${pending} 
    Write Excel Cell    8    6    ${len} 
    Save Excel Document    ${inputfilepath} 
    Close Current Excel Document 
    Continue For Loop 
        
contiune for loop and update count smililar tech
    [Arguments]   ${count}   ${rowcount}   ${len}  
    Open Excel Document    ${inputfilepath}    doc_id=input4
    Write Excel Cell    4    9    ${rowcount} 
    Write Excel Cell    6    9    ${count}
    ${pending}=  Evaluate   ${len}-${count}
    Write Excel Cell    7    9   ${pending}
    Write Excel Cell    5    9    ${len}
    Save Excel Document    ${inputfilepath} 
    Close Current Excel Document
    continue For Loop
    
contiune for loop and update count Seamless  
    [Arguments]   ${count}   ${rowcount}  ${len}  ${excefilename}  ${message} 
    Write logs  ${excefilename}  ${message}
    Open Excel Document    ${inputfilepath}    doc_id=input4
    Write Excel Cell    7    12    ${rowcount} 
    Write Excel Cell    9    12    ${count}
    ${pending}=  Evaluate   ${len}-${count} 
    Write Excel Cell    10    12    ${pending} 
    Write Excel Cell    8    12    ${len} 
    Save Excel Document    ${inputfilepath} 
    Close Current Excel Document 
    Continue For Loop  

CleanUp
    
    Remove Files    ${EXECDIR}${/}*.png
    run keyword if   '${TEST_NAME}'!='Seamless'    Close All Browsers
    #sleep   300s
    #Close All Browsers
    


SeamlessDemo
    Log To Console    ${empty}
    Open Excel Document    ${inputfilepath}    doc_id=input4
    ${category}=   Read Excel Cell    13    3  
    ${username}=  Read Excel Cell    3    12
    ${password}=  Read Excel Cell    4    12
    ${brandcolnum}=  read excel cell   5    12 
    ${outputcolstart}=  Read Excel Cell    6    12
    ${filename}=  read excel cell     14    3
    ${currentrow}=  read excel cell    7   12
    ${noOfRows}=   Read Excel cell    11    12  
    Close Current Excel Document
    
    ${excefilename}=  Create Excecution file    Seamless
    Append To File    ${excefilename}   content=[Start]\n
    Write logs  ${excefilename}    **********************Seamless AI Started***********************************
  
    Write logs  ${excefilename}    Execution Log file name = ${excefilename} 
    Write logs  ${excefilename}    Seamless User Name = ${username}
    Write logs  ${excefilename}    Seamless User Password = ${password}        
    Write logs  ${excefilename}    Brand Column No = ${brandcolnum}
    Write logs  ${excefilename}    Output Column Start No = ${outputcolstart}    
    Write logs  ${excefilename}    Reading data from excel file= ${filename}       
    Write logs  ${excefilename}    Current Row Number= ${currentrow}
       
    #login to seamless  ${username}      ${password} 
    Init Webdriver
    Run Keyword And Continue On Failure    Maximize Browser Window
    
    Open Excel Document    ${filename}    doc_id=input5
    ${list}=    Read Excel Column    ${brandcolnum} 
    Close Current Excel Document
    
    Create File    ${EXECDIR}${/}LinkedInDeMo${/}Assets${/}Input${/}Logs${/}seamless_${category}.txt
    
    ${len}=   Get Length    ${list}
    Log To Console    Toltal Brands =${len} 
    run keyword if  '${noOfRows}'=='None'   Set Local Variable   ${noOfRows}   ${len}
    ${noOfRows}=  Evaluate  ${noOfRows}+1
    
    FOR    ${count}    IN RANGE   ${currentrow}    ${noOfRows} 
        Write logs  ${excefilename}     *******************************************************
        Write logs  ${excefilename}    Row Number ${count} Out of Brands ${len}
        Write logs  ${excefilename}    Company Name=${list}[${count}]
        ${lines}=   grep file   ${EXECDIR}${/}LinkedInDeMo${/}Assets${/}Input${/}Logs${/}seamless_${category}.txt   ${list}[${count}]
        ${length}=   Get Length    ${lines}
        ${rowcount}=   Evaluate    ${count}+1    
        Run Keyword If    ${length}!=0     contiune for loop and update count Seamless   ${count}    ${rowcount}  ${len}  ${excefilename}   Brand details already fetched           
        navigate to company 
        ${st1}=  Search company deatils    ${list}[${count}]   ${excefilename} 
        Run Keyword If    '${st1}'=='False'   contiune for loop and update count Seamless   ${count}    ${rowcount}  ${len}  ${excefilename}     Brand Details Not available on Seamless
        ${st2}=  Search Person details    CEO   Owner   ${filename}      ${rowcount}   ${outputcolstart}  ${excefilename}
        Run Keyword If    '${st2}'=='False'  Run Keyword And Continue On Failure   Search Person details    President  Director   ${filename}     ${rowcount}   ${outputcolstart}     ${excefilename} 
        Write logs  ${excefilename}    *******************************************************
  
        Open Excel Document    ${inputfilepath}    doc_id=input4
        Write Excel Cell    7    12    ${rowcount} 
        Write Excel Cell    9    12    ${count}
        ${pending}=  Evaluate   ${len}-${count} 
        Write Excel Cell    10    12    ${pending}
        Write Excel Cell    8    12    ${len} 
        Save Excel Document    ${inputfilepath} 
        Close Current Excel Document  
        Close All Excel Documents
        Append To File    ${EXECDIR}${/}LinkedInDeMo${/}Assets${/}Input${/}Logs${/}seamless_${category}.txt    content=${list}[${count}]\n  
    END
    Write logs  ${excefilename}   **********************Seamless AI END***********************************  
    Append To File    ${excefilename}   content=[END]\n

contiune for loop and update count Company details 
    [Arguments]    ${count}    ${rowcount}  ${len}  
    Open Excel Document    ${inputfilepath}    doc_id=id 
    Write Excel Cell    6    6    ${rowcount} 
    Write Excel Cell    8    6    ${count}
    ${pending}=  Evaluate   ${len}-${count}
    Write Excel Cell    9    6   ${pending}
    Write Excel Cell    7    6    ${len}       
    Save Excel Document    ${inputfilepath} 
    Close Current Excel Document
    Continue For Loop    

Company details 
    log to console   ${empty}
    ${excefilename}=   Create Excecution file  CompanyDetails
    Append to file    ${excefilename}    content=[Start]\n 
    Open Excel Document    ${inputFilePath}    doc_id=input6
    ${websitecolno}=  Read Excel Cell    3    6    
    ${filename}=    Read Excel Cell    14    3    
    ${brandscolno}=   Read Excel Cell    4     6 
    ${outputcolstart}=  Read Excel Cell    5    6
    ${currentcolno}=  Read Excel Cell    6    6     
    ${noofrows}=   Read Excel Cell         10   6
    Close Current Excel Document
    
    Write logs  ${excefilename}    *********************************************************
    Write logs  ${excefilename}    Fetching Company Details
    Write logs  ${excefilename}    Reading data from excel file = ${filename}
    Write logs  ${excefilename}    Company website column No. = ${websitecolno}
    Write logs  ${excefilename}    Brand Column No = ${brandscolno}
    Write logs  ${excefilename}    Output Column Start No. =${outputcolstart}
    Write logs  ${excefilename}    Current Row No. = ${currentcolno}
    Write logs  ${excefilename}    No of rows will be executed= ${noofrows}
    
    Open Excel Document    ${filename}    doc_id=input7 
    ${brands}=    Read Excel Column    ${brandscolno}  
    ${list}=    Read Excel Column    ${websitecolno}
    ${len}=   Get Length    ${brands}
    Close Current Excel Document
    
    Write logs  ${excefilename}    Total Brands= ${len}   
    #Write logs  ${excefilename}  current Row number= ${currentcolno} 
    
    common Open brower    https://www.google.com/ 
    ${noOfRows}=  Evaluate  ${noOfRows}+1  
    run keyword if  '${noOfRows}'=='None'   Set Local Variable   ${noOfRows}   ${len}+1  
    FOR    ${count}    IN RANGE  ${currentcolno}          ${noofrows} 
        Write logs  ${excefilename}    ********************************************* 
        Write logs  ${excefilename}    Row Number= ${count}    
        Write logs  ${excefilename}    Company Name=${list}[${count}]  
        ${rowcount}=   Evaluate    ${count}+1 
        Run Keyword If   '${list}[${count}]'=='None'   contiune for loop and update count smililar tech   ${count}    ${rowcount}  ${len}  
        #log to console   ${list}[${count}]
        Go To    ${list}[${count}]
        #Reload Page
        sleep     3s
        Run Keyword And Continue On Failure  Wait Until Page Contains Element       //a[contains(@href,'facebook')]    10s  
        ${facebook}=  Run Keyword And Continue On Failure  Get Element Attribute    //a[contains(@href,'facebook')]    href
        Run Keyword And Continue On Failure  Wait Until Page Contains Element        //a[contains(@href,'instagram')]    5s
        ${instagram}=  Run Keyword And Continue On Failure  Get Element Attribute    //a[contains(@href,'instagram')]    href
        Run Keyword And Continue On Failure  Wait Until Page Contains Element        //a[contains(@href,'linkedin')]    5s
        ${company_linkedin}=  Run Keyword And Continue On Failure  Get Element Attribute    //a[contains(@href,'linkedin')]    href

        ${linkedurlcol}=    Evaluate    ${outputcolstart}+2
        ${facebookurlcol}=    Evaluate    ${outputcolstart}+3
        ${instagramurlcol}=    Evaluate    ${outputcolstart}+4
        
        Open Excel Document    ${filename}    doc_id=input5     
        Write Excel Cell    ${index}    ${linkedurlcol}    ${company_linkedin}  
        Write Excel Cell    ${index}    ${facebookurlcol}    ${facebook}
        Write Excel Cell    ${index}    ${instagramurlcol}    ${instagram}
        Save Excel Document    ${filename} 
        Close Current Excel Document      
        Write logs  ${excefilename}    Facebook = ${facebook} 
        Write logs  ${excefilename}   Instagram = ${instagram}
        Write logs  ${excefilename}   LinkedIn = ${company_linkedin}
        Write logs  ${excefilename}    *********************************************************
        Open Excel Document    ${inputfilepath}    doc_id=id 
        Write Excel Cell    6    6    ${rowcount} 
        Write Excel Cell    8    6    ${count}
        ${pending}=  Evaluate   ${len}-${count}
        Write Excel Cell    9    6   ${pending}
        Write Excel Cell    7    6    ${len}       
        Save Excel Document    ${inputfilepath} 
        Close Current Excel Document
    END
    Close All Excel Documents
    Write logs  ${excefilename}    *****************************End****************************
    Append to file    ${excefilename}    content=[END]\n


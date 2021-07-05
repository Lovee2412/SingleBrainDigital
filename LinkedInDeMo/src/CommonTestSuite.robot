*** Settings ***
Resource    LinkedIN.robot 
Resource    SmartScoutapp.robot
Resource    SimilarTechapp.robot
library     ExcelLibrary 
Library     SeleniumLibrary 
Library     OperatingSystem    

*** Variables ***
${id}                      op
${inputfilepath}           #${EXECDIR}${/}Assets${/}Input${/}Smartscout_Appliance.xlsx
${brandcolnum}             2s
${outputcolstart}          13 

${browserName}                  chrome
#${downloadDir}                ${EXECDIR}
      

*** Test Cases ***
#SmartScout 
#       smartscout for multiple category

#Prepare excel 
#    Prepare Output Excel
    
# Linkedin 
     # linkedin Flow
     
SimilarTech 
    SimilarTech excel Demo


     
*** Keywords ***


# SmartScout for all category              
    # login to smartscout   
    # Navigate to brand 
    # FOR  ${categorys}  IN  @{categoeries}
        # Wait Until Keyword Succeeds  2  2s  smartscout brand info export     ${categorys}
        # move file     C:${/}Users${/}LENOVO${/}Downloads${/}SmartScout*.xlsx           C:${/}Users${/}LENOVO${/}Downloads${/}Smartscout_${categorys}.xlsx
        # move file     C:${/}Users${/}LENOVO${/}Downloads${/}SmartScout*.xlsx           ${EXECDIR}${/}Assets${/}Input${/}
    # END 
    
        
# smartscout for single category
    # login to smartscout   
    # Navigate to brand 
    # Wait Until Keyword Succeeds  2  2s    smartscout brand info export    ${category}
    # move file     C:${/}Users${/}LENOVO${/}Downloads${/}SmartScout*.xlsx           C:${/}Users${/}LENOVO${/}Downloads${/}Smartscout_${category}.xlsx
    # move file     C:${/}Users${/}LENOVO${/}Downloads${/}SmartScout*.xlsx           ${EXECDIR}${/}Assets${/}Input${/}
    

smartscout for multiple category
    Log To Console    *********************************************************    
    Log To Console    Starting SmartScout
    Log To Console    Download path = ${downloadDir}    
    Log To Console    Reading data from = ${inputfilepath} 
    Open Excel Document    ${inputfilepath}    doc_id =inputfile   
    ${username}=  Read Excel Cell    3    3  
    Log To Console    SmartScout User Name = ${username}
    ${Password}=  Read Excel Cell    4    3 
    Log To Console    SmartScout User Password = ${Password}
    ${avg_selling_price}=   Read Excel Cell    5    3  
    Log To Console    Average Selling Price = ${avg_selling_price}
    ${monthly_revenue_start}=   Read Excel Cell    6    3
    ${monthly_revenue_end}=  Read Excel Cell    7    3
    ${amazonStockRate}=  Read Excel Cell    8    3     
    ${avgsellerStart}=  Read Excel Cell    9    3
    ${avgsellerend}=     Read Excel Cell    10    3
    ${brandscorestart}=  Read Excel Cell    11    3
    ${brandscoreend}=   Read Excel Cell    12    3
    ${category}=  Read Excel Cell    13    3    
    Log To Console    Monthly Revenue Start = ${monthly_revenue_start}     
    Log To Console    Monthly Revenue End = ${monthly_revenue_end}    
    Log To Console    Amazon Stock Rate = ${amazonStockRate}    
    Log To Console    Average Seller Start = ${avgsellerStart}    
    Log To Console    Average Seller End = ${avgsellerend}
    Log To Console    Brand Score Start = ${brandscorestart}    
    Log To Console    Brand Score End = ${brandscoreend} 
    Log To Console    Category = ${category}              
    Wait Until Keyword Succeeds  2x  2s   smartscout flow  ${username}   ${password}   ${category}   ${amazonStockRate}  ${avgsellerStart}  ${avgsellerend}  ${avg_selling_price}
    ...  ${monthly_revenue_start}  ${monthly_revenue_end}  ${brandscorestart}  ${brandscoreend}
     Log To Console    Download directory = ${downloadDir}   
     @{filename}=   List Files In Directory    ${downloadDir} 
     Log To Console    Exported file name=${downloadDir}${/}${filename}[0]
     write excel cell  14   3   ${downloadDir}${/}${filename}[0]
     Save Excel Document    ${inputfilepath}
     Close All Excel Documents
     

Prepare Output Excel
     Log to console     preparing excel file with header column
     Open Excel Document    ${inputfilepath}    doc_id=inputfile
     ${filename}=   Read Excel Cell    14      3           
     Open Excel Document   ${filename}    doc_id=${id}
     #Write Excel Cell    1    ${brandcolnum}    Brand   
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
     Write Excel Cell    1     ${monthlycol}   Monthly Visitors
     Write Excel Cell   1     ${directcol}    Direct       
     Write Excel Cell    1     ${serachcol}    Serach
     Write Excel Cell    1    ${socialcol}    Social
     Write Excel Cell    1     ${referralscol}    Referrals
     Write Excel Cell    1    ${mailcol}         Mail     
     Write Excel Cell    1     ${displaycol}    Display

     Save Excel Document   ${filename}
     Close Current Excel Document



linkedin Flow
    #Set Selenium Speed    1s
    Log to console  *******************************************
    Log to Console  LINKEDIN FLOW STARTING
    Open Excel Document    ${inputfilepath}    doc_id=inputfile1
    ${username}=  Read Excel Cell    3    6
    Log to console   Linked User Name=${username}
    ${password}=  Read Excel Cell    4    6  
    Log To Console    Linked User Password     
    ${brandcolnum}=  read excel cell   5    6
    Log to console   Brand Column No.= ${brandcolnum}
    ${outputcolstart}=  Read Excel Cell    6    6
    Log To Console    Output Column Start No= ${outputcolstart}    
    ${filename}=  read excel cell     14    3 
    Log to console   Reading data from excel file= ${filename}       
    ${currentrow}=  read excel cell    7   6
    Log to console  Current Row Number= ${currentrow}
    login to LinkedIn   ${username}       ${password}
    Open Excel Document    ${filename}    doc_id=${id}
    ${list}=    Read Excel Column    ${brandcolnum} 
    ${len}=   Get Length    ${list}
    Log To Console    Toltal Brands =${len} 
    FOR    ${count}    IN RANGE   ${currentrow}    ${len} 
        Log To Console    ******************************************    
        Log to console    Row Number ${count} Out of Brands ${len}
        Log To Console    Company Name=${list}[${count}]    
        ${status}=  Search by company name  ${list}[${count}]
        Log To Console    ${status}    
        Run Keyword if    '${status}'=='False'   Continue For Loop  
        Log To Console    after continue     
        ${rowcount}=   Evaluate    ${count}+1    
        get company details  ${list}[${count}]   ${id}  ${rowcount}  ${filename}  ${outputcolstart}
        Log To Console     ******************************************
        #${index}=  Evaluate    ${index}+1  
        Save Excel Document    ${filename} 
        Switch Current Excel Document    inputfile1
        Write Excel Cell    7    6    ${rowcount} 
        Save Excel Document    ${inputfilepath}   
     END
    Save Excel Document    ${filename}
    Close All Excel Documents
    

SimilarTech excel Demo
    Open Excel Document    ${inputFilePath}    doc_id=inputfile2
    ${websitecolno}=  Read Excel Cell    3    9    
    ${filename}=    Read Excel Cell    14    3    
    Log to console   Reading data from excel file = ${filename}
    Log to console   Company website column no = ${websitecolno}
    ${currentcolno}=  Read Excel Cell    4    9 
    ${brandscolno}=   Read Excel Cell    5     6 
    
    
    Open Excel Document    ${filename}    doc_id=inputfile3  
    ${brands}=    Read Excel Column    ${brandscolno} 
    log to console  Brands = ${brands}   
    ${list}=    Read Excel Column    ${websitecolno}
    log to console   company websites=${list}
    ${len}=   Get Length    ${brands}
    Log To Console    Total Brands= ${len}   
    log to console  current Row number= ${currentcolno} 
    #Log To Console    ${list}    
    common Open brower    ${baseURL}    
    FOR    ${count}    IN RANGE  ${currentcolno}   ${len} 
        Log To Console    ********************************************* 
        Log To Console    Row Number= ${count}    
        Log To Console    Company Name=${list}[${count}]  
        ${rowcount}=   Evaluate    ${count}+1 
        #log to console        ********************************************* 
        Run Keyword If   '${list}[${count}]'=='None'    Continue For Loop    
        log to console   ${baseURL}${list}[${count}]
        Go To    ${baseURL}${list}[${count}]
        Reload Page
        sleep     3s
        ${status}=   Run Keyword And Return Status    Wait Until Page Contains Element    //div[@class="no-data-available"]   10s      
        run keyword if     '${status}'=='True'  Continue For Loop  
        SimilarTech    inputfile3  ${rowcount}  ${outputcolstart}
        Save Excel Document    ${filename}  
        Switch Current Excel Document    doc_id=inputfile2  
        Write Excel Cell    4    9    ${rowcount}  
        Save Excel Document    ${inputfilepath} 
        Switch Current Excel Document    inputfile3 
    END
    Save Excel Document    ${filename}
    Save Excel Document    ${inputFilePath}
    Close All Excel Documents
    

   
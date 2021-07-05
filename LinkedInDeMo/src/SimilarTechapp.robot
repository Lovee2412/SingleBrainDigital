*** Settings ***
Library    SeleniumLibrary 
library     ExcelLibrary    


*** Variables ***
@{urls}    https://www.utzy.com/    http://www.lifoam.com/    http://www.aulterra.com/    http://yoronaturals.com/  http://www.mpmmed.com/   http://www.curednutrition.com/
${baseURL}                 https://addon.similartech.com/addons/a/1.1.0/chrome/91.0.4472.114/discover?url=
${browserName}                  chrome
#${downloadDir}                ${EXECDIR}

#${id}                      op
#${inputFilePath}           ${EXECDIR}${/}Assets${/}Input${/}File1.xlsx
#${outputColstart}          17

*** Keywords ***
# SimilarTech 
    # Open Browser    url=None     browser=gc
    # FOR   ${url}  IN  @{urls}
        # log to console     *************************************************
        # log to console   ${baseURL}${url}  
        # Go To    ${baseURL}${url} 
        # Wait Until Page Contains Element    //div[@class="visits-value"]    60s
        # ${monthlyvisit}=    get text        //div[@class="visits-value"] 
        # Wait Until Page Contains Element    //li[@data-key="direct"]//div[@class="legend-value"]    45s
        # ${direct}=  get text                //li[@data-key="direct"]//div[@class="legend-value"]
        # Wait Until Page Contains Element    //li[@data-key="search"]//div[@class="legend-value"]    
        # ${serach}=   get text              //li[@data-key="search"]//div[@class="legend-value"]
        # ${social}=   get text              //li[@data-key="social"]//div[@class="legend-value"]
        # ${display}=  get text              //li[@data-key="display"]//div[@class="legend-value"]
        # ${referrals}=  get text           //li[@data-key="referrals"]//div[@class="legend-value"]
        # ${mail}=   get text               //li[@data-key="mail"]//div[@class="legend-value"]    
        # log to console                    Monthly Visits = ${monthlyvisit}
        # log to console                    Direct = ${direct}
        # log to console                    Search = ${serach}
        # log to console                    Social = ${social}
        # log to console                    Display = ${display}
        # log to console                    Referrals = ${referrals}
        # Log to console                    Mail = ${mail} 
        # log to console        *********************************************      
  
    # END


SimilarTech
    [Arguments]      ${id}   ${rownum}  ${outputColstart}
       
        Reload Page 
        Run Keyword And Continue On Failure  Wait Until Page Contains Element    //div[@class="visits-value"]    60s
        ${monthlyvisit}=  Run Keyword And Continue On Failure   get text        //div[@class="visits-value"] 
        Run Keyword And Continue On Failure  Wait Until Page Contains Element    //li[@data-key="direct"]//div[@class="legend-value"]    45s
        ${direct}=   Run Keyword And Continue On Failure   get text                //li[@data-key="direct"]//div[@class="legend-value"]
        Run Keyword And Continue On Failure   Wait Until Page Contains Element    //li[@data-key="search"]//div[@class="legend-value"]    
        ${serach}=  Run Keyword And Continue On Failure    get text              //li[@data-key="search"]//div[@class="legend-value"]
        ${social}=  Run Keyword And Continue On Failure   get text              //li[@data-key="social"]//div[@class="legend-value"]
        ${display}=  Run Keyword And Continue On Failure   get text              //li[@data-key="display"]//div[@class="legend-value"]
        ${referrals}=  Run Keyword And Continue On Failure  get text           //li[@data-key="referrals"]//div[@class="legend-value"]
        ${mail}=  Run Keyword And Continue On Failure   get text               //li[@data-key="mail"]//div[@class="legend-value"]    
        log to console                    Monthly Visits = ${monthlyvisit}
        log to console                    Direct = ${direct}
        log to console                    Search = ${serach}
        log to console                    Social = ${social}
        log to console                    Display = ${display}
        log to console                    Referrals = ${referrals}
        Log to console                    Mail = ${mail} 
        log to console        *********************************************   
        
        Switch Current Excel Document    ${id}
        ${monthlycol}=  Evaluate    ${outputColstart}+5    
        ${directcol}=  Evaluate     ${outputColstart}+6
        ${serachcol}=   Evaluate     ${outputColstart}+7    
        ${socialcol}=   Evaluate     ${outputColstart}+8  
        ${displaycol}=   Evaluate     ${outputColstart}+9  
        ${referralscol}=   Evaluate     ${outputColstart}+10  
        ${mailcol}=   Evaluate     ${outputColstart}+11 
        Write Excel Cell    ${rownum}     ${monthlycol}   ${monthlyvisit}
        Write Excel Cell    ${rownum}     ${directcol}    ${direct}       
        Write Excel Cell    ${rownum}     ${serachcol}    ${serach}
        Write Excel Cell    ${rownum}     ${socialcol}    ${social}
        Write Excel Cell    ${rownum}     ${referralscol}    ${referrals}
        Write Excel Cell    ${rownum}     ${mailcol}         ${mail}
        Write Excel Cell    ${rownum}     ${displaycol}        ${display}


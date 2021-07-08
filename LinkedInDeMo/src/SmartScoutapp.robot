*** Settings ***
library              SeleniumLibrary    
library              OperatingSystem 
Resource             CommonKeywords.robot
   
*** Variables ***
${smartscoutURL}                https://app.smartscout.com/sessions/signin
${smartscout_username}          Andrew@singlebrain.io
${smartscout_password}          $inglebrain1
${avg_selling_price}            14

${monthly_revenue_start}        5000
${monthly_revenue_end}          20000
${amazonStockRate}              15
${avgsellerStart}               1
${avgsellerend}                 5
${brandscorestart}              4
${brandscoreend}                6
${category}                     Appliance
@{categoeries}                  Appliance    Arts, Crafts & Sewing    Automotive    Baby Products    Beauty & Personal Care    Books
...                             CDs & Vinyl    Cell Phones & Accessories    Clothing, Shoes & Jewelry    Collectibles & Fine Art    Electronics
...                             Entertainment    Everything Else    Gift Cards    Grocery & Gourmet Food    Handmade Products    Health & Household    Home & Kitchen
...                             Industrial & Scientific    Kitchen & Dining    Musical Instruments    Office Products    Patio, Lawn & Garden    Pet Supplies    Software
...                             Sports & Outdoors    Team Sports    Tools & Home Improvement    Toys & Games    Video Games

@{list}                         Appliance    Arts, Crafts & Sewing    Automotive    Baby Products


*** Keywords ***



login to smartscout
    [Arguments]   ${smartscout_username}     ${smartscout_password}
    common Open brower    ${smartscoutURL} 
    Log To Console    Browser opened   
    Maximize Browser Window
    # Wait Until Page Contains Element    //input[@id="username"]     50s
    # Input Text          ${smartscout_username}
    Common Input Text    Entering User Name   //input[@id="username"]     ${smartscout_username}
    Common Input Password  Entering User Password   //input[@id="password"]    ${smartscout_password}
    common click element   Clicking on Signin Button   //button[@id="btnSignin"]  
    Run Keyword And Continue On Failure    Wait Until Page Does Not Contain    Please wait    60s   
    
Navigate to brand           
    Wait Until Page Contains Element    //img[@class="app-logo ng-star-inserted"]            50s
    # wait until page contains element    //a[@id="navBrands"]                                 30s
    # Wait Until Element Is Enabled       //a[@id="navBrands"]                                 40s
    sleep                               10s
    common Click Element     Clicking on Brands     //a[@id="navBrands"]    

smartscout brand info export 
    [Arguments]      ${category}    ${amazonStockRate}  ${avgsellerStart}  ${avgsellerend}  ${avg_selling_price}  ${monthly_revenue_start}  ${monthly_revenue_end}  ${brandscorestart}  ${brandscoreend}
    sleep                               5s
   # wait until page contains element    //button[@id="btnClear"]                             40s
    common click element        clicking on clear            //button[@id="btnClear"]  
    #Wait Until Page Contains Element    //div[@class="mat-select-arrow ng-tns-c110-41"]      50s
    common Click Element    clicking on an arrow            //div[@class="mat-select-arrow ng-tns-c110-41"]
    #Wait Until Page Contains Element    //input[@placeholder="Select category"]              50s
    common Input Text        Entering category      //input[@placeholder="Select category"]              ${category} 
    common Click Element  clicking on search        //span[@class="mat-option-text" and contains(.,'${category}')] 
    Run Keyword If  '${amazonStockRate}'!='NA'  common Input Text  Entering Amazon stock rate  //input[@id="mat-input-4"]    ${amazonStockRate}
    Run Keyword If  '${avgsellerStart}'!='NA'   common input text  Entering Avg seller start  //input[@id="mat-input-6"]    ${avgsellerStart}
    Run Keyword If  '${avgsellerend}'!='NA'     common input text  Entering Avg seller end  //input[@id="mat-input-7"]    ${avgsellerend} 
    Run Keyword If  '${avg_selling_price}'!='NA'  common Input Text  Entering avg selling price  //input[@id="mat-input-8"]    ${avg_selling_price}   
    Run Keyword If  '${monthly_revenue_start}'!='NA'  common Input Text   Entering Monthly Revenue start   //input[@id="mat-input-10"]   ${monthly_revenue_start}
    Run Keyword If  '${monthly_revenue_end}'!='NA'  common Input Text   Entering monthly revenue end   //input[@id="mat-input-11"]   ${monthly_revenue_end}  
    Run Keyword If  '${brandscorestart}'!='NA'  common input text  Entering brand Score start   //input[@id="mat-input-22"]   ${brandscorestart}
    Run Keyword If  '${brandscoreend}'!='NA'  common input text  Entering Brand score end   //input[@id="mat-input-23"]   ${brandscoreend}  
    common Click Element      Clicking on Search                 //button[@id="btnSearchBrands"]   
    sleep                               3s
    #Wait Until Page Contains Element    //span[@style="transform: rotate(180deg);"]           50s    
    common Click Element    Clicking on arrow                   //span[@style="transform: rotate(180deg);"]   
    Wait Until Page Does Not Contain    Loading    60s     
    sleep                               3s
    #Wait Until Page Contains Element    //img[@src="/assets/buyboxer/images/excel.png"]       50s    
    common Click Element     Clicking on excel                  //img[@src="/assets/buyboxer/images/excel.png"]  
    #Click Element                       //img[@src="/assets/buyboxer/images/excel.png"] 
    #Wait Until Page Contains Element    //img[@mattooltip="Export products to Excel"]         50s
    #Wait Until Element Is Visible       //img[@mattooltip="Export products to Excel"]         50s   
    sleep                               5s
    common Click Element        clicking on export excel               //img[@mattooltip="Export products to Excel"]  
    Run Keyword And Continue On Failure    Wait Until Page Does Not Contain    Please wait    40s     
    sleep                               3s
    # Wait Until Element Is Visible       //img[@src="/assets/buyboxer/images/excel.png"]        40s
    # Wait Until Element Is Enabled       //img[@src="/assets/buyboxer/images/excel.png"]        40s
    common Click Element    clicking on export   //img[@src="/assets/buyboxer/images/excel.png"] 
    sleep                               3s
    #Wait Until Page Contains Element    //span[@style="transform: rotate(0deg);"]             30s
    common click element    clicking on arrow                   //span[@style="transform: rotate(0deg);"] 
    Log To Console    File is exported at ${downloadDir}
     
   
smartscout flow
    [Arguments]  ${username}   ${password}   ${category}   ${amazonStockRate}  ${avgsellerStart}  ${avgsellerend}  ${avg_selling_price}  ${monthly_revenue_start}  ${monthly_revenue_end}  ${brandscorestart}  ${brandscoreend}    
    login to smartscout   ${username}   ${password}
    Navigate to brand 
    smartscout brand info export    ${category}   ${amazonStockRate}  ${avgsellerStart}  ${avgsellerend}  ${avg_selling_price}  ${monthly_revenue_start}  ${monthly_revenue_end}  ${brandscorestart}  ${brandscoreend}    




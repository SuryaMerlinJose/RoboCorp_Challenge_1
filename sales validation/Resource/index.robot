*** Settings ***
Documentation       Sales Order Validation Bot
Library             RPA.Browser.Selenium    auto_close= ${True}
Library             RPA.HTTP
Library             RPA.Excel.Files
Library             Collections
Library             RPA.FTP
Library             python/shipment_excel_file.py

*** Keywords ***
Fetching Login Details
    # &{dict}    Create Dictionary
    Set Download Directory    sales validation/Files
    Open Available Browser    https://developer.automationanywhere.com/challenges/salesorder-challenge.html?_gl=1*1sxkjqa*_ga*ODM0OTU3ODM3LjE3MDQ3Njc1MDg.*_ga_DG1BTLENXK*MTcwNTMwMjk1Ny43LjEuMTcwNTMwMzI2My42MC4wLjA.&_ga=2.17151801.1214561463.1705302958-834957837.1704767508
    Maximize Browser Window
    
    
    Wait Until Element Contains    onetrust-accept-btn-handler    Accept All Cookies  
    Click Element When Visible    onetrust-accept-btn-handler 
    Click Button    //*[@id="button_modal-login-btn__iPh6x"]

    Wait Until Element Is Visible    //*[@placeholder="*Email"]
    Input Text    //*[@placeholder="*Email"]    suryamerlinjose@gmail.com
    Click Button    //button[contains(text(),"Next")]
    Wait Until Element Is Visible    //*[@placeholder="Password"]
    Input Password    //*[@placeholder="Password"]    surya123
    Click Button    //*[contains(text(),"Log in")]
    
    Wait Until Element Is Visible    //*[contains(text(),"Sales App Login")]
    Scroll Element Into View    //*[contains(text(),"Global Express Tracking")]
    Wait Until Element Is Visible    //*[contains(text(),"Global Express Tracking")]
    # # Scroll Element Into View    //*[contains(text(),"Global Express Tracking")]
    ${login_data}    Get Element Attribute    //div[@class='col-sm']    textContent 
    Log To Console    ${login_data}    
    Log    ${login_data}   

    ${username}    ${Password}    shipment_excel_file.fetch_login_data    ${login_data}
    Set Global Variable    ${username}
    Set Global Variable    ${Password}
    
    # Sleep    2s
    Click Element        //*[contains(text(),"Sales App Login")]

Global Express Tracking
    Switch Window    main 
    Wait Until Element Is Visible    //a[contains(text(),"Track")]
    Scroll Element Into View    //h3[contains(text(),"Sales Validation")]
    Click Element     //a[contains(text(),"Track")]
    Switch Window    new    
    

Sales Validation
    Scroll Element Into View    //*[@id="fileToUpload"]
    Wait Until Element Is Visible    //*[@id="fileToUpload"]
    Choose File    //*[@id="fileToUpload"]    Files/Sales Order.csv
    Click Button    //*[@id="btnUploadFile"] 

# *** Tasks ***
# sample
#     Fetching Login Details
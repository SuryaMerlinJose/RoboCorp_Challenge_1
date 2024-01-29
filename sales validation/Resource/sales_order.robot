*** Settings ***
Documentation       Sales Order Validation Bot
Library             RPA.Browser.Selenium    auto_close= ${True}
Library             RPA.HTTP
Library             RPA.Excel.Files
Library             Collections
Resource            Resource/index.robot 
Library             python/shipment_excel_file.py
Library             OperatingSystem

*** Variables ***
@{shipment_excel}    
${status}
*** Keywords ***
sales Order Login
    Input Text    //*[@id="salesOrderInputEmail"]     ${username}
    # Input Text When Element Is Visible    //*[@id="salesOrderInputEmail"]    douglasmcgee@catchycomponents.com
    Input Password    //*[@id="salesOrderInputPassword"]    ${Password}
    Click Element    //a[contains(text(),"Login")]

sales order from dashboard
    
     Wait Until Element Is Visible    //*[@id="accordionSidebar"]/li[6]/a/span
     Click Element    //*[@id="accordionSidebar"]/li[6]/a/span 

    # @{list_data}    Create List
   
    FOR    ${i}    IN RANGE    1    2  #actual range is 22

        ${dataTable_count}    Get Element Count    //*[@id="salesOrderDataTable"]/tbody/tr
        Log    ${dataTable_count}
        FOR    ${counter}    IN RANGE    1    ${dataTable_count}
        Log    ${counter}
        # ${order_status}    Get Text    //*[@id="salesOrderDataTable"]/tbody/tr[${counter}]/td[5]
        # Log    ${order_status}

        # IF    "${order_status}" == "Confirmed" or "${order_status}" == "Delivery Outstanding"
            # Log    ${order_status}

            Click Element    //*[@id="salesOrderDataTable"]/tbody/tr[${counter}]/td[1]/i    #plus symbol

            ${salesOrderDataTable}    Get Element Count     //*[@id="salesOrderDataTable"]/tbody/tr/td/table/tbody/tr
            Log    ${salesOrderDataTable}

            @{list_data}    Create List

            FOR    ${t_no}    IN RANGE    1    ${salesOrderDataTable}    #table displayed when + is clicked
                ${TR}    Get Text    //*[@id="salesOrderDataTable"]/tbody/tr/td/table/tbody/tr[${t_no}]/td[2]
                Log    ${TR}
                Append To List     ${list_data}    ${TR} 

                # Track Your Sales Order    ${list_data} 
                Log    ${list_data}
            END
        
            Track Your Sales Order    ${list_data}     #holds the list of Tracking Numbers from salesOrderDataTable
            
            #if SCHEDULED DELIVERY of all the TRACKING NUMBER's in ${list_data} == Delivered  then "generate invoice" else "close" we are using python function for this 
            
            Switch Window    title:Sales Order - List 
            IF    "${status}" == "True"
                Click Button    //*[contains(text(),"Generate Invoice")]
            ELSE
                Click Button    //*[contains(text(),"Close")]
            END
            # Sleep    3s
              
        # END
        
    END
            
            Click Element    //*[@id="salesOrderDataTable_next"]    #next button
    END
    click button    //*[contains(text(),"Export")]    
    Sleep    3s
       
  



Track Your Sales Order        #put this inside another robot file

    Switch Window    title:Sales Order - Tracking

    [Arguments]    ${list_data}
    
    FOR    ${t_num}    IN    @{list_data}
        Log    ${t_num}
        Wait Until Element Is Visible    //*[@id="inputTrackingNo"]
        Input Text    //*[@id="inputTrackingNo"]    ${t_num}
        Click Button    //*[@id="btnCheckStatus"]
        # ${Shipment_overview}    Get Element Count    //*[@id="shipmentStatus"]/tr
        # Log     ${Shipment_overview}



        &{dict}    Create Dictionary
        @{shipment_excel}    Create List
        Wait Until Element Is Visible    //*[@id="shipmentStatus"]
        ${track_no}    Get Text    //*[@id="shipmentStatus"]/tr[1]/td[2]
        Log    ${track_no}
        ${ship_date}    Get Text   //*[@id="shipmentStatus"]/tr[2]/td[2]
        Log    ${ship_date} 
        ${ship_status}    Get Text    //*[@id="shipmentStatus"]/tr[3]/td[2]
        Log    ${ship_status}    
        Set To Dictionary    ${dict}    track_no=${track_no}    ship_date=${ship_date}      ship_status=${ship_status} 
        # shipment_excel_file.shipment_csv     ${dict}

        IF    "${dict}[ship_status]" == "Delivered"
            Set Variable    ${status}    True
        ELSE
            Set Variable    ${status}    True
        END
        Set Global Variable    ${status}
        #  Return From Keyword    ${status}
        # Append To List    ${shipment_excel}    ${dict} 
        # shipment_excel_file.shipment_csv     ${shipment_excel}   
        # Return From Keyword     ${shipment_excel}  
        # sleep     3s
    END
    Append To List    ${shipment_excel}    ${dict}
    Log    ${shipment_excel} 
    shipment_excel_file.shipment_csv     ${shipment_excel}
    # Log    ${shipment_excel}   
    # Return From Keyword     ${shipment_excel}
    Switch Window    title:Sales Order - List 
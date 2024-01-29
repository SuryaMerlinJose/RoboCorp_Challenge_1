*** Settings ***
Documentation       Sales Order Validation Bot
Library             RPA.Browser.Selenium    auto_close= ${True}
Library             RPA.HTTP
Library             RPA.Excel.Files
Library             Collections
Resource            Resource/index.robot 
Resource            Resource/sales_order.robot   
*** Tasks ***
Sales Order Validation
    Fetching Login Details
    Switch Window    new
    sales Order Login
    Switch Window    main 
    Global Express Tracking
    Switch Window    title:Sales Order - Home 
    sales order from dashboard
    Switch Window    title:Sales Order - Validation 
    Sales Validation
   
    


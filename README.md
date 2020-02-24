# EOS

EOS is a project that fetches the account data of Wombat EOS wallet using it's the Public API provided in Developer Portal.
https://developers.eos.io/manuals/eos/latest/nodeos/plugins/chain_api_plugin/api-reference/index


# Technical details!

- Every module will have a presenter, model and viewController/views
- All the bussiness logic is written in presenter and data is passed to viewController via delegates
- NetworkInterface singleton will take care of fetching data from servers
- Data fetched from servers are stored into Model using Codable protocols
- Used MARK: in the code and added the detailed description of individual methods functionality


# Business Logic!

### NET Calculation

- Net progress percentage is calulated as (net_limit.used / net_limit.available) * 100
- This is calculated in method "calculateAndProcess_NET()" in EOSProfilePresenter presenter class

### CPU Calculation

- CPU progress percentage is calulated as (cpu_limit.used / cpu_limit.available) * 100
- This is calculated in method "calculateAndProcess_CPU()" in EOSProfilePresenter presenter class

### RAM Calculation

- Net progress percentage is calulated as (ram_usage / ram_quota) * 100
- This is calculated in method "calculateAndProcess_RAM()" in EOSProfilePresenter presenter class

### Dollar Value Conversion

- Based on the screenshoot given in the assignment I see that the dollars per unit is "4.2801"
- 39.60/9.2521 = 4.2801 so I have used 4.2801 as current dollars per unit 

### Convert bytes to KB, MB or BG
- The values that are received in the JSON response are in bytes. 
- I have written a method that takes the input in bytes and converts that into KB or GB and returns a string. 

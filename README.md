# EOS

EOS is a project that fetches the account data of Wombat EOS wallet using it's the Public API provided in Developer Portal.
https://developers.eos.io/manuals/eos/latest/nodeos/plugins/chain_api_plugin/api-reference/index


# Technical details!

- Every module will have a presenter, model and viewController/views
- All the bussiness logic is written in presenter and data is passed to viewController via delegates
- NetworkInterface singleton will take care of fetching data from servers
- Data fetched from servers are stored into Model using Codable protocols
- Used MARK: in the code and added the detailed description of individual methods functionality

# Azure DNS

This addon uses the azure-cli to update a Azure DNS recordset with the current ip. In order to update the Azure DNS recordset a service principal must be created. Please follow this [documentation](https://docs.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal) to create a service principal.

The service principal needs to have the followin permissions

- Subscription-Level: DNS Zone Contributer

Copy the following data to the configuration

| Config name   | Azure information                                    |
| ------------- | ---------------------------------------------------- |
| tenantid      | Directory (tenant) ID                                |
| clientid      | Application (client) ID                              |
| clientsecret  | Value of the generated client secret                 |
| resourcegroup | Name of the resourcegroup that contains the DNS zone |
| zone          | The name of the DNS zone resource                    |
| recordset     | The name of the recordset                            |

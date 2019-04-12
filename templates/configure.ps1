
$serverUrl = "https://alexlyoninfoblox.uksouth.cloudapp.azure.com"
$apiVersion = "v2.6"
$apiUrl = "$serverUrl/wapi/$apiVersion"
$perms = "-u admin:adminPassword1"

# list api versions
curl -k "$serverUrl/wapi/v1.0/?_schema" -u admin:adminPassword1 


# consent_banner_setting
$gridRef = (curl -k1 -u admin:adminPassword1 "$apiUrl/grid" -X GET | ConvertFrom-Json)._ref
curl -k -u admin:adminPassword1 -X GET "https://alexlyoninfoblox.uksouth.cloudapp.azure.com/wapi/v2.6/grid" -X GET -d _return_fields=consent_banner_setting
curl -k -u admin:adminPassword1 -X PUT -H 'content-type: application/json' "$($apiUrl)/$($gridRef)" -d '{\"consent_banner_setting\": {\"enable\": false}}'

# security settings
curl -k -u admin:adminPassword1 -X PUT -H 'content-type: application/json' "$($apiUrl)/$($gridRef)?_return_as_object=1&_return_fields%2B=security_setting" -d '{\"security_setting\": {\"session_timeout\": 60000}}'


# export records as json - parse them to a file
curl -k1 -u admin:adminPassword1 -H "Content-Type: application/json" -X GET https://alexlyoninfoblox.uksouth.cloudapp.azure.com/wapi/v2.6/allrecords -d '{\"view\": \"default\",\"zone\": \"authforward\"}'

# get a records
curl -k1 -u admin:adminPassword1 -X GET https://alexlyoninfoblox.uksouth.cloudapp.azure.com/wapi/v2.6/record:a?_return_as_object=1

# create a record
curl -k1 -u admin:adminPassword1 -H "Content-Type: application/json" -X POST https://alexlyoninfoblox.uksouth.cloudapp.azure.com/wapi/v2.6/record:a -d '{\"name\": \"a2.authforward\",\"ipv4addr\": \"10.1.0.3\"}'

# Get the fwd authoritive zone
curl -k1 -u admin:adminPassword1 -X GET "https://alexlyoninfoblox.uksouth.cloudapp.azure.com/wapi/v2.6/zone_auth?_return_as_object=1"

# create fwd authoritive zone
curl -k -u admin:adminPassword1 -H "Content-Type: application/json" -X POST https://alexlyoninfoblox.uksouth.cloudapp.azure.com/wapi/v2.6/zone_auth -d '{\"fqdn\": \"authforward\"}'

# modify zone to add NS
$zoneRef = (curl -k1 -u admin:adminPassword1 "$apiUrl/zone_auth" -X GET | ConvertFrom-Json)._ref
curl -k -u admin:adminPassword1 -H "Content-Type: application/json" -X PUT "$($apiUrl)/$($zoneRef)?_return_fields%2B=fqdn,grid_primary&_return_as_object=1" -d '{\"grid_primary\":[{\"name\":\"infoblox.localdomain\"}]}'

# restart services
curl -k -u admin:adminPassword1 -H "Content-Type: application/json" -X POST https://alexlyoninfoblox.uksouth.cloudapp.azure.com/wapi/v2.6/$($gridRef)?_function=requestrestartservicestatus -d '{\"service_option\": \"ALL | DHCP | DNS\"}'
curl -k -u admin:adminPassword1 -H "Content-Type: application/json" -X POST "https://alexlyoninfoblox.uksouth.cloudapp.azure.com/wapi/v2.6/grid/b25lLmNsdXN0ZXIkMA:Infoblox?_function=requestrestartservicestatus" -d '{\"service_option\": \"ALL\"}'
curl -k -u admin:adminPassword1 -H 'content-type: application/json' -X POST "https://alexlyoninfoblox.uksouth.cloudapp.azure.com/wapi/v2.6/grid/b25lLmNsdXN0ZXIkMA:Infoblox?_function=restartservices" -d '{\"member_order\" : \"SIMULTANEOUSLY\",\"service_option\": \"ALL\"}'


curl -k -u admin:adminPassword1 -c cookies.txt -X GET "$apiUrl/record:host?_return_as_object=1"
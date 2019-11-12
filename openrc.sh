#!/bin/zsh

# With the addition of Keystone, to use an openstack cloud you should
# authenticate against keystone, which returns a **Token** and **Service
# Catalog**.  The catalog contains the endpoint for all services the
# user/tenant has access to - including nova, glance, keystone, swift.
#
# *NOTE*: Using the 2.0 *auth api* does not mean that compute api is 2.0.  We
# will use the 1.1 *compute api*
export OS_AUTH_URL=http://ostack:5000/v2.0

# With the addition of Keystone we have standardized on the term **tenant**
# as the entity that owns the resources.
export OS_TENANT_ID=43b789bfb2cd43dd91854cc5fd481409
export OS_TENANT_NAME=admin

# In addition to the owning entity (tenant), openstack stores the entity
# performing the action as the **user**.
export OS_USERNAME=admin

# With Keystone you pass the keystone password.
export OS_PASSWORD=1qaz@WSX
export OS_AUTH_SYSTEM=rackspace
export OS_REGION_NAME=LON
export OS_NO_CACHE=1
export ADMIN_PASSWORD=1qaz@WSX
export SERVICE_PASSWORD=1qaz@WSX
export SERVICE_TOKEN=r4th3rb3t0k3n
export SERVICE_ENDPOINT="http://ostack:35357/v2.0"
export SERVICE_TENANT_NAME=service
